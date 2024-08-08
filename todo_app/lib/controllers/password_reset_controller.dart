import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetController extends GetxController {
  var email = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void resetPassword() async {
    if (email.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter an email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      print("Attempting to send password reset email to: ${email.value}");
      await _auth.sendPasswordResetEmail(email: email.value);
      print("Password reset email sent successfully!");
      Get.snackbar(
        'Success',
        'Password Reset Email has been sent!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}");
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error',
          'Invalid email address.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("An unknown error occurred: $e");
      Get.snackbar(
        'Error',
        'An error occurred while trying to send the reset email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
