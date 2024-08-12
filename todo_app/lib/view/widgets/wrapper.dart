import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/screens/signin.dart';
import 'package:todo_app/view/screens/splashscreen.dart';
import 'package:todo_app/view/screens/too_list.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("ERROR!"),
              );
            } else {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SignIn();
              } else {
                print('user is logged in');
                return const TodoListPage();
              }
            }
          }),
    );
  }
}
