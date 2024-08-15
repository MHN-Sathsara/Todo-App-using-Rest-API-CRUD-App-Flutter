// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/view/screens/splashscreen.dart';
// import '../screens/signin.dart';
import '../screens/too_list.dart';

class Wrapper extends StatelessWidget {
  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    // Check login state
    if (_authService.checkUserLoginState() != null) {
      return const TodoListPage();
    } else {
      return const MySplashscreen();
    }
  }
}
