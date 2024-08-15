import 'package:get/get.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  final AuthService _authService = Get.find<AuthService>();

  void signIn(BuildContext context) async {
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      await _authService.signIn(
        email: email.value,
        password: password.value,
        context: context,
      );
    } else {
      // Handle empty fields, show error, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password'),
        ),
      );
    }
  }

  // Update email and password values
  void updateEmail(String value) {
    email.value = value;
  }

  void updatePassword(String value) {
    password.value = value;
  }
}
