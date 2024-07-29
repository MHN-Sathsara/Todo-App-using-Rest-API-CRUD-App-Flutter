import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/controllers/todo_controller.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit
                ? () => updateData(todoController)
                : () => submitData(todoController),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData(TodoController todoController) async {
    final todo = widget.todo;
    if (todo == null) {
      Get.snackbar('Error', 'You cannot call update without todo data',
          backgroundColor: Colors.red);
      return;
    }

    final id = todo['_id'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = 'https://api.nstack.in/v1/todos/$id';
    final Dio dio = Dio();

    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        titleController.text = '';
        descriptionController.text = '';
        Get.snackbar('Success', 'Update Success!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        todoController.fetchTodos();
      } else {
        Get.snackbar('Error', 'Update Failed', backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  Future<void> submitData(TodoController todoController) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    const url = 'https://api.nstack.in/v1/todos';
    final Dio dio = Dio();
    //final uri = Uri.parse(url);
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201) {
        titleController.text = '';
        descriptionController.text = '';
        Get.snackbar('Success', 'Creation Success!',
            backgroundColor: Colors.green);
        todoController.fetchTodos();
      } else {
        Get.snackbar('Error', 'Creation Failed', backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit data',
          backgroundColor: Colors.red);
    }
  }
}
