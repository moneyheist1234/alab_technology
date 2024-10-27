import 'package:alab_technology/authentication/execptions/signup_email_password_failure.dart';
import 'package:alab_technology/screens/home_screen.dart';
import 'package:alab_technology/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => Home());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    _showLoadingDialog(); // Show loading dialog
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => LoginScreen());
      _showSuccessSnackbar('Account created successfully! Please login.');
    } on FirebaseAuthException catch (e) {
      final failure = SignupEmailPasswordFailure.code(e.code);
      _showErrorSnackbar(failure.message);
    } catch (e) {
      _showErrorSnackbar('An unknown error occurred');
    } finally {
      Get.back(); // Close loading dialog
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _showLoadingDialog(); // Show loading dialog
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Close loading dialog after successful login
      Get.back();
      _showSuccessSnackbar('Login successful!');
    } on FirebaseAuthException catch (e) {
      // Close loading dialog in case of an error
      Get.back();

      // Handle specific Firebase error codes
      if (e.code == 'user-not-found') {
        _showErrorSnackbar(
            'No user found with this email. Please check or register.');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackbar('Incorrect password. Please try again.');
      } else {
        final failure = SignupEmailPasswordFailure.code(e.code);
        _showErrorSnackbar(failure.message);
      }
    } catch (e) {
      Get.back(); // Close loading dialog for unknown errors
      _showErrorSnackbar(
          'An unknown error occurred or User not found please register and come back!');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      _showErrorSnackbar('Error during logout');
    }
  }

  // Loading dialog with theme color
  void _showLoadingDialog() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Get.theme.primaryColor, // Using theme's primary color
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
}
