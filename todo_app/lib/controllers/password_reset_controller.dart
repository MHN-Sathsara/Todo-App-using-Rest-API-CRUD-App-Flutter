import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  var email = ''.obs;

  void resetPassword() {
    // Implement the logic to send a password reset email
    // For example, you can call an API to send the reset link to the user's email
    print('Reset password for email: ${email.value}');
    // Show a confirmation message or navigate to another page
    Get.snackbar('Password Reset',
        'A password reset link has been sent to ${email.value}');
  }
}
