import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/screens/too_list.dart';
import 'package:todo_app/view/screens/add_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const TodoListPage()),
        GetPage(name: '/add', page: () => const AddTodoPage()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TodoListPage(),
    );
  }
}
