import 'package:flutter/material.dart';

import 'dart:ui';

class CheckWidget extends StatefulWidget {
  final double size;
  final bool start;
  final VoidCallback onEnd;

  const CheckWidget({
    Key? key,
    required this.size,
    required this.start,
    required this.onEnd,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckWidgetState();
}

class CheckWidgetState extends State<CheckWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late Animation<double> valueAnimation;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
    animationController.addStatusListener(listenerAnimationStatus);

    valueAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    animationController.removeStatusListener(listenerAnimationStatus);
    animationController.dispose();
    super.dispose();
  }

  void listenerAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) animationController.reverse();
      });
    } else if (status == AnimationStatus.dismissed) {
      widget.onEnd();
    }
  }

  @override
  void didUpdateWidget(covariant CheckWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (mounted && widget.start) animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnimatedPathPainter(
        valueAnimation,
        Colors.white,
        widget.size * 0.1,
      ),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;
  final Color _color;
  final double? strokeWidth;

  AnimatedPathPainter(
    this._animation,
    this._color,
    this.strokeWidth,
  ) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(0.27083 * size.width, 0.54167 * size.height)
      ..lineTo(0.41667 * size.width, 0.68750 * size.height)
      ..lineTo(0.75000 * size.width, 0.35417 * size.height);
  }

  Path createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength =
        originalPath.computeMetrics().fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
    final currentLength = totalLength * animationPercent;
    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;
    final path = Path();
    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;
      var nextLength = currentLength + metric.length;
      final isLastSegment = nextLength > length;

      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = _animation.value;
    final path = createAnimatedPath(_createAnyPath(size), animationPercent);
    final Paint paint = Paint();

    paint.color = _color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth ?? size.width * 0.06;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
