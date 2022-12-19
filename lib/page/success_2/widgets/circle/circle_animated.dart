import 'package:flutter/material.dart';

import 'circle_border_widget.dart';

class CircleAnimated extends StatelessWidget {
  const CircleAnimated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleBorderWidget(size: 120);
  }
}
