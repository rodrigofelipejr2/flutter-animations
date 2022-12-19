import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/page/success_3/widgets/circle/circle_widget.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

class Success3Page extends StatefulWidget {
  const Success3Page({Key? key}) : super(key: key);

  @override
  State<Success3Page> createState() => _Success3PageState();
}

class _Success3PageState extends State<Success3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 6),
            child: const Center(
              child: CircleWidget(size: 75),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
