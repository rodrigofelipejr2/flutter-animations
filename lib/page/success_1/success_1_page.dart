import 'package:flutter/material.dart';

import '../widgets/success_body_widget.dart';
import '../widgets/success_header_widget.dart';

class Success1Page extends StatelessWidget {
  const Success1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            flex: 7,
            child: SuccessHeaderWidget(),
          ),
          Expanded(
            flex: 4,
            child: SuccessBodyWidget(),
          ),
        ],
      ),
    );
  }
}
