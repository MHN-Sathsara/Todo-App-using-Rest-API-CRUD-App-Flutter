import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/view/screens/splashscreen.dart';
import '../screens/too_list.dart';

class Wrapper extends StatelessWidget {
  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authService
          .getLoginState(), // Use getLoginState() instead of checkUserLoginState()
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData && snapshot.data == true) {
            return const TodoListPage();
          } else {
            return const MySplashscreen();
          }
        }
      },
    );
  }
}
