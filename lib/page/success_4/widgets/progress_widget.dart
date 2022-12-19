import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

import 'circle/check_widget.dart';
import 'custom_border_progress.dart';

class ProgressWidget extends StatefulWidget {
  final double size;

  const ProgressWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> with TickerProviderStateMixin {
  Color backgroundColor = Constants.iOrange;
  AnimationStatus? scaleStatus;
  bool showBackground = false;
  bool animationCheck = false;
  bool opacityCheck = false;
  bool visibleBackCircle = false;

  late Animation<double> firstScaleAnimation;
  late Animation<double> secondScaleAnimation;
  late Animation<double> thirdScaleAnimation;

  late AnimationController firstScaleAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
  late AnimationController secondScaleAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 650));
  late AnimationController thirdScaleAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 350));

  @override
  void initState() {
    super.initState();
    firstScaleAnimationController.addListener(() => setState(() {}));
    thirdScaleAnimationController.addListener(() => setState(() {}));
    secondScaleAnimationController.addListener(() {
      setState(() {
        if (scaleStatus == AnimationStatus.forward) {
          if (secondScaleAnimationController.value > 0.35) {
            backgroundColor = Constants.iGreen;
          }

          if (secondScaleAnimationController.value > 0.6) {
            animationCheck = true;
          }
        }
      });
    });

    secondScaleAnimationController.addStatusListener(secondScaleStatusListener);

    firstScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: firstScaleAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    secondScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: secondScaleAnimationController,
        curve: const Cubic(0.175, 0.885, 0.32, 1.375),
      ),
    );

    thirdScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: thirdScaleAnimationController,
        curve: Curves.easeIn,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) firstScaleAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    firstScaleAnimationController.dispose();
    secondScaleAnimationController.removeStatusListener(secondScaleStatusListener);
    secondScaleAnimationController.dispose();
    thirdScaleAnimationController.dispose();
    super.dispose();
  }

  void secondScaleStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      scaleStatus = status;
    } else {
      scaleStatus = null;
    }
  }

  double ignoreZero(double value) => value == 0 ? 1.0 : value;

  double get flowRateApproach => widget.size * 1.04;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
      decoration: BoxDecoration(color: backgroundColor),
      child: Center(
        child: Transform.scale(
          scale: firstScaleAnimation.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 135),
                opacity: showBackground ? 1.0 : 0.0,
                curve: Curves.easeInCubic,
                child: Container(
                  decoration: const BoxDecoration(color: Constants.iWhite),
                  height: double.maxFinite,
                  width: double.maxFinite,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: widget.size * 0.012),
                  shape: BoxShape.circle,
                ),
                height: widget.size,
                width: widget.size,
              ),
              Opacity(
                opacity: visibleBackCircle ? 1.0 : 0.0,
                child: Transform.scale(
                  scale: (thirdScaleAnimation.value + 0.5) * 1.7,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: 1.0 - thirdScaleAnimation.value,
                    curve: Curves.easeInCubic,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Constants.iWhite),
                      height: widget.size * 1.1,
                      width: widget.size * 1.1,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: secondScaleAnimation.value,
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  height: widget.size,
                  width: widget.size,
                  child: Center(
                    child: SizedBox(
                      height: widget.size * 0.8,
                      width: widget.size * 0.8,
                      child: CheckWidget(
                        size: widget.size,
                        start: animationCheck,
                        opacity: opacityCheck,
                        color: Constants.iDarkGreen,
                        onEnd: () {
                          Future.delayed(const Duration(milliseconds: 500)).then((_) {
                            setState(() {
                              visibleBackCircle = true;
                            });
                          });

                          Future.delayed(const Duration(seconds: 1)).then((_) {
                            setState(() {
                              opacityCheck = true;
                              thirdScaleAnimationController.forward();
                              Future.delayed(const Duration(milliseconds: 125)).then((_) {
                                setState(() {
                                  showBackground = true;
                                });
                              });

                              Future.delayed(const Duration(milliseconds: 260)).then((_) {
                                Navigator.of(context).pop();
                              });
                            });
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: flowRateApproach,
                width: flowRateApproach,
                child: CustomBorderProgress(
                  size: flowRateApproach,
                  color: Constants.iWhite,
                  onEnd: () => secondScaleAnimationController.forward(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
