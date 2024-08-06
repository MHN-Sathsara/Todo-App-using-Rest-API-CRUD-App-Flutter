import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/password_reset_controller.dart';
import 'package:todo_app/utils/themes/colorsp.dart';

class PasswordResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PasswordResetController controller =
        Get.put(PasswordResetController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your email to receive a password reset link',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: controller.resetPassword,
                child: const Text(
                  'Send Reset Link',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
