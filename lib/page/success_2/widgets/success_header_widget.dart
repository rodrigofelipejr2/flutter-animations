import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/success_2/widgets/circle/circle_animated.dart';
import 'package:flutter_application_success_page/shared/widgets/delayed_display.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

class SuccessHeaderWidget extends StatelessWidget {
  const SuccessHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final radius = constraints.maxWidth * 3;

      return Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            color: Constants.background,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          Positioned(
            bottom: 0,
            left: -radius / 3,
            child: SafeArea(
              child: DelayedDisplay(
                fadingDuration: const Duration(milliseconds: 550),
                slidingBeginOffset: const Offset(0.0, -0.1),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  child: Container(
                    height: radius,
                    width: radius,
                    color: Constants.greenBack,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            child: DelayedDisplay(
              delay: Duration(milliseconds: 350),
              slidingBeginOffset: Offset(0.0, 0.0),
              child: CircleAnimated(),
            ),
          )
        ],
      );
    });
  }
}
