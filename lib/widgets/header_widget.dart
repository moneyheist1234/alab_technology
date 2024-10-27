import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderWidget({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40), // Space from the app bar
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Be Vietnam',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        SizedBox(height: 90), // Space after title
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF261C12),
            fontSize: 32,
            fontFamily: 'Be Vietnam',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ],
    );
  }
}
