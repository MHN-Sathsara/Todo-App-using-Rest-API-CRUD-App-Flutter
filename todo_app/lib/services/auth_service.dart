// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/view/screens/home_page.dart';
import 'package:todo_app/view/screens/splashscreen.dart';

// import 'package:todo_app/view/widgets/wrapper.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _weakPasswordErrorCode = 'weak-password';
  static const String _emailAlreadyInUseErrorCode = 'email-already-in-use';
  static const String _invalidEmailErrorCode = 'invalid-email';
  static const String _wrongPasswordErrorCode = 'wrong-password';

  static const String _weakPasswordErrorMessage =
      'The password provided is too weak.';
  static const String _emailAlreadyInUseErrorMessage =
      'An account already exists with that email.';
  static const String _invalidEmailErrorMessage =
      'No user found for that email.';
  static const String _wrongPasswordErrorMessage =
      'Wrong password provided for that user.';

  User? checkUserLoginState() {
    return _auth.currentUser;
  }

  //save login satet in shared preference
  Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  //retrun login state from shared preference
  Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveLoginState(true); //savelogin
      await Future.delayed(const Duration(seconds: 1));
      _navigateToTodoListPage(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, context);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await saveLoginState(true); //savelogin
      await Future.delayed(const Duration(seconds: 1));
      _navigateToTodoListPage(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e, context);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await saveLoginState(false); // Clear login state
    _navigateToWrapperPage(context);
  }

  void _handleAuthException(FirebaseAuthException e, BuildContext context) {
    String message = '';
    switch (e.code) {
      case _weakPasswordErrorCode:
        message = _weakPasswordErrorMessage;
        break;
      case _emailAlreadyInUseErrorCode:
        message = _emailAlreadyInUseErrorMessage;
        break;
      case _invalidEmailErrorCode:
        message = _invalidEmailErrorMessage;
        break;
      case _wrongPasswordErrorCode:
        message = _wrongPasswordErrorMessage;
        break;
      default:
        message = 'An error occurred. Please try again later.';
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void _navigateToTodoListPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _navigateToWrapperPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MySplashscreen()),
    );
  }

  void regin(
      {required String email,
      required String password,
      required BuildContext context}) {}
}
