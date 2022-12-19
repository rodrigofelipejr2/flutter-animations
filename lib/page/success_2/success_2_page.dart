import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/success_2/widgets/success_body_widget.dart';
import 'package:flutter_application_success_page/page/success_2/widgets/success_header_widget.dart';

class Success2Page extends StatelessWidget {
  const Success2Page({Key? key}) : super(key: key);

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
