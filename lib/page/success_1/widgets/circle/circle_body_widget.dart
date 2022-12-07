import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import 'check_widget.dart';

class CircleBodyWidget extends StatefulWidget {
  final double size;
  final double referenceSize;
  final VoidCallback onEnd;

  const CircleBodyWidget({
    Key? key,
    required this.size,
    required this.referenceSize,
    required this.onEnd,
  }) : super(key: key);

  @override
  State<CircleBodyWidget> createState() => _CircleBodyWidgetState();
}

class _CircleBodyWidgetState extends State<CircleBodyWidget> {
  bool checkVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Constants.greenLine,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: widget.size,
              width: widget.size,
              onEnd: () {
                setState(() {
                  widget.onEnd();
                  checkVisible = true;
                });
              },
              decoration: const BoxDecoration(
                color: Constants.greenBack,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Positioned(
          child: Visibility(
            visible: checkVisible,
            child: CheckWidget(
              size: widget.referenceSize * 0.75,
            ),
          ),
        ),
      ],
    );
  }
}
