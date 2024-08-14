import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/view/screens/home_page.dart';
import 'package:todo_app/view/widgets/wrapper.dart';
import 'firebase_options.dart';
import 'package:todo_app/view/screens/registration_page.dart';
import 'package:todo_app/view/screens/signin.dart';
import 'package:todo_app/view/screens/splashscreen.dart';
import 'package:todo_app/view/screens/add_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
  Get.put(AuthService()); // Register AuthService with GetX

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Wrapper()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/spash', page: () => const MySplashscreen()),
        GetPage(name: '/regp', page: () => const RegistrationPage()),
        GetPage(name: '/signin', page: () => const SignIn()),
        GetPage(name: '/add', page: () => const AddTodoPage()),
      ],
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
