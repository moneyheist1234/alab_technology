import 'package:alab_technology/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpTextWidget extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const SignUpTextWidget(
      {Key? key,
      required this.questionText,
      required this.actionText,
      required this.onActionTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: questionText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.3),
              fontSize: 14,
              fontFamily: 'Be Vietnam',
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: actionText,
            style: TextStyle(
              color: kThemeColor,
              fontSize: 14,
              fontFamily: 'Be Vietnam',
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()..onTap = onActionTap,
          ),
        ],
      ),
    );
  }
}
