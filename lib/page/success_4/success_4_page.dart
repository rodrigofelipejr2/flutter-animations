import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/success_4/widgets/progress_widget.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

class Success4Page extends StatefulWidget {
  const Success4Page({Key? key}) : super(key: key);

  @override
  State<Success4Page> createState() => _Success4PageState();
}

class _Success4PageState extends State<Success4Page> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.iOrange,
      body: ProgressWidget(size: 90),
    );
  }
}
