import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alab_technology/controllers/signup_controller.dart';
import 'package:alab_technology/controllers/login_controller.dart';
import 'package:alab_technology/screens/login_screen.dart';
import 'package:alab_technology/widgets/custom_button_widget.dart';
import 'package:alab_technology/widgets/custom_text_field_widget.dart';
import 'package:alab_technology/widgets/header_widget.dart';
import 'package:alab_technology/widgets/social_login_widget.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final signupController = Get.put(SignupController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  title: 'Alabtechnology Private Limited',
                  subtitle: 'Sign Up!',
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.to(() => LoginScreen()),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF261C12),
                            fontSize: 12,
                            fontFamily: 'Be Vietnam',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Color(0xFFD5715B),
                            fontSize: 12,
                            fontFamily: 'Be Vietnam',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomTextFieldWidget(
                  controller: signupController.fullName,
                  hintText: 'Full Name',
                  iconPath: 'assets/icons/user_icon.png',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFieldWidget(
                  controller: signupController.email,
                  hintText: 'Email Address',
                  iconPath: 'assets/icons/email.png',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFieldWidget(
                  controller: signupController.password,
                  hintText: 'Password',
                  iconPath: 'assets/icons/password.png',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomButtonWidget(
                  text: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signupController.registerUser(
                        signupController.email.text.trim(),
                        signupController.password.text.trim(),
                        signupController.fullName.text.trim(),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'or sign up with',
                    style: TextStyle(
                      color: Color(0x4C261C12),
                      fontSize: 10,
                      fontFamily: 'Be Vietnam',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: SocialLoginWidget(
                          iconPath: 'assets/icons/google_icon.png',
                          onTap: () => signupController.signUpWithGoogle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
