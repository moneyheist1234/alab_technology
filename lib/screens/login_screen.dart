import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alab_technology/screens/home_screen.dart';
import 'package:alab_technology/controllers/login_controller.dart';
import 'package:alab_technology/screens/signup_screen.dart';
import 'package:alab_technology/widgets/custom_button_widget.dart';
import 'package:alab_technology/widgets/custom_text_field_widget.dart';
import 'package:alab_technology/widgets/header_widget.dart';
import 'package:alab_technology/widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  final bool fromLogout;
  final bool fromSignup;

  const LoginScreen({
    Key? key,
    this.fromLogout = false,
    this.fromSignup = false,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.fromSignup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Success',
          'Account created! Please login.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xFFD5715B).withOpacity(0.1),
          colorText: Color(0xFFD5715B),
        );
      });
    }
  }

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
                  subtitle: 'Login!',
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.back(); // Ensure no dialogs are open
                    Get.to(() => SignUpScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF261C12),
                            fontSize: 12,
                            fontFamily: 'Be Vietnam',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
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
                  controller: loginController.email,
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
                  controller: loginController.password,
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
                  text: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.loginUser(
                        loginController.email.text.trim(),
                        loginController.password.text.trim(),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'or login with',
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
                          onTap: () async {
                            await loginController.signInWithGoogle();
                          },
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
