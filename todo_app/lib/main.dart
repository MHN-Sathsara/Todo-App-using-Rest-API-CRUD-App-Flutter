import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:todo_app/view/screens/registration_page.dart';
import 'package:todo_app/view/screens/signin.dart';
import 'package:todo_app/view/screens/splashscreen.dart';
import 'package:todo_app/view/screens/too_list.dart';
import 'package:todo_app/view/screens/add_page.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MySplashscreen()),
        GetPage(name: '/regp', page: () => const RegistrationPage()),
        GetPage(name: '/signin', page: () => const SignIn()),
        GetPage(name: '/list', page: () => const TodoListPage()),
        GetPage(name: '/add', page: () => const AddTodoPage()),
      ],
      debugShowCheckedModeBanner: false,
      home: const MySplashscreen(),
    );
  }
}
