import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:alab_technology/screens/login_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Controllers for the signup form
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final isLoading = false.obs;

  void registerUser(String email, String password, String fullName) async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      // Create user in Firebase
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(fullName);

      // Clear the form fields
      this.email.clear();
      this.password.clear();
      this.fullName.clear();

      Get.back(); // Close loading dialog

      Get.snackbar(
        'Success',
        'Account created successfully! Please login.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xFFD5715B).withOpacity(0.1),
        colorText: Color(0xFFD5715B),
        duration: Duration(seconds: 3),
      );

      // Navigate to login screen
      Get.offAll(() => LoginScreen(fromSignup: true));
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;
      _showLoadingDialog();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.back();
        return; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      Get.back(); // Close loading dialog

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        Get.snackbar(
          'Welcome!',
          'Account created successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xFFD5715B).withOpacity(0.1),
          colorText: Color(0xFFD5715B),
          duration: Duration(seconds: 3),
        );
      }

      Get.offAll(() => LoginScreen(fromSignup: true));
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showLoadingDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD5715B)),
                ),
                SizedBox(height: 15),
                Text(
                  'Please wait...',
                  style: TextStyle(
                    color: Color(0xFFD5715B),
                    fontSize: 12,
                    fontFamily: 'Be Vietnam',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    // Dispose the controllers when the controller is removed from memory
    email.dispose();
    password.dispose();
    fullName.dispose();
    super.onClose();
  }
}
