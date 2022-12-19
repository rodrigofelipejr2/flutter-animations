import 'package:flutter/material.dart';

class CheckWidget extends StatefulWidget {
  final double size;

  const CheckWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckWidgetState();
}

class CheckWidgetState extends State<CheckWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late Animation<double> scaleAnimation;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));

    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleAnimation.value,
      child: CustomPaint(
        foregroundPainter: CheckCustomPainter(Colors.white),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}

class CheckCustomPainter extends CustomPainter {
  final Color _color;

  CheckCustomPainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.stroke;
    paint.color = _color;
    paint.strokeWidth = size.width * 0.1;
    canvas.drawPath(_createAnyPath(size), paint);
  }

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(0.27083 * size.width, 0.54167 * size.height)
      ..lineTo(0.41667 * size.width, 0.68750 * size.height)
      ..lineTo(0.75000 * size.width, 0.35417 * size.height);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
