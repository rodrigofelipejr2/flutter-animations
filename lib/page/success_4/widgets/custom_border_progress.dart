import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../shared/widgets/progress_border.dart';
import '../../../utils/constants.dart';

class CustomBorderProgress extends StatefulWidget {
  final double size;
  final VoidCallback onEnd;
  final Color color;

  const CustomBorderProgress({
    Key? key,
    required this.size,
    required this.onEnd,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomBorderProgress> createState() => _CustomBorderProgressState();
}

class _CustomBorderProgressState extends State<CustomBorderProgress> with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  late Animation<double> valueAnimation;

  @override
  void initState() {
    super.initState();
    animationController.addListener(() => setState(() {}));
    animationController.addStatusListener(listenerAnimationStatus);

    valueAnimation = Tween(
      begin: 0.0,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
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

  void listenerAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      widget.onEnd();
    }
  }

  static const double _strokeHeadInterval = 0.33;

  late final Animatable<double> _additionalRotationTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 4.0),
        weight: _strokeHeadInterval,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi * _additionalRotationTween.transform(valueAnimation.value),
      filterQuality: FilterQuality.high,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Constants.transparent,
          shape: BoxShape.circle,
          border: ProgressBorder.all(
            color: widget.color,
            width: widget.size * 0.05,
            progress: valueAnimation.value,
          ),
        ),
      ),
    );
  }
}
