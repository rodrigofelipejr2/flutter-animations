import 'package:flutter/material.dart';
import 'package:flutter_application_success_page/utils/constants.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.black,
      body: Center(
        child: Text(
          'Unknown Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
