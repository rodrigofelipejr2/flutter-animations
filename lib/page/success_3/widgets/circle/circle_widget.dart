import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/success_3/widgets/circle/check_widget.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

class CircleWidget extends StatefulWidget {
  final double size;

  const CircleWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<CircleWidget> createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late Animation<double> scaleAnimation;
  bool nextStep = false;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
    animationController.addStatusListener(listenerAnimation);

    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    animationController.removeStatusListener(listenerAnimation);
    animationController.dispose();
    super.dispose();
  }

  void listenerAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        nextStep = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleAnimation.value,
      child: Container(
        decoration: const BoxDecoration(
          color: Constants.greenLine,
          shape: BoxShape.circle,
        ),
        height: widget.size,
        width: widget.size,
        child: CheckWidget(
          size: widget.size,
          start: nextStep,
          onEnd: () {
            setState(() {
              nextStep = false;
            });
            if (mounted) animationController.reverse();
          },
        ),
      ),
    );
  }
}
