import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../shared/widgets/progress_border.dart';
import 'circle_body_widget.dart';

class CircleBorderWidget extends StatefulWidget {
  final double size;

  const CircleBorderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<CircleBorderWidget> createState() => _CircleBorderWidgetState();
}

class _CircleBorderWidgetState extends State<CircleBorderWidget> with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late Animation<double> valueAnimation;
  int circleSize = 1;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
    animationController.addStatusListener(listenerAnimationStatus);

    valueAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    animationController.removeStatusListener(listenerAnimationStatus);
    animationController.dispose();
    super.dispose();
  }

  void restartAnimationBorder() {
    if (animationController.status == AnimationStatus.forward || animationController.value >= 1) {
      setState(() {
        circleSize = 0;
      });
    } else {
      setState(() {
        animationController.forward();
      });
    }
  }

  void listenerAnimationStatus(AnimationStatus status) {
    if ([AnimationStatus.completed, AnimationStatus.dismissed].contains(status)) {
      restartAnimationBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Constants.greenBack,
          shape: BoxShape.circle,
          border: ProgressBorder.all(
            color: Constants.greenLine,
            width: widget.size * 0.05,
            progress: valueAnimation.value,
          ),
        ),
        child: CircleBodyWidget(
          size: widget.size * circleSize,
          referenceSize: widget.size,
          onEnd: () {
            setState(() {
              circleSize = 0;
            });
          },
        ),
      ),
    );
  }
}
