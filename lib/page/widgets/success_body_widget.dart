import 'package:flutter/material.dart';

import '../success_1/widgets/circle/delayed_display.dart';
import '../../utils/constants.dart';
import '../success_1/success_1_page.dart';

class SuccessBodyWidget extends StatelessWidget {
  const SuccessBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Constants.background,
      child: DelayedDisplay(
        fadingDuration: const Duration(milliseconds: 550),
        slidingBeginOffset: const Offset(0.0, 0.05),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 28, bottom: 14),
              child: Text(
                'New goal added!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Constants.textBody,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Text(
                'Run 369km before 16 September, 2021',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Constants.textBody,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    maxHeight: 48,
                    minHeight: 48,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
