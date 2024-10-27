import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final bool obscureText;
  final String? Function(String?)? validator;
  static const kThemeColor = Color(0xFF1A43BF);

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: kThemeColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kThemeColor,
          selectionColor: kThemeColor.withOpacity(0.2),
          selectionHandleColor: kThemeColor,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        cursorColor: kThemeColor,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Image.asset(iconPath),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kThemeColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
        ),
      ),
    );
  }
}
