import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoController extends GetxController {
  var todos = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  Future<void> fetchTodos() async {
    isLoading(true);
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      todos.assignAll(result);
    }
    isLoading(false);
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      todos.removeWhere((item) => item['_id'] == id);
      Get.snackbar('Success', 'Todo Deteled Successfully',
          backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to delete todo',
          backgroundColor: Colors.red);
    }
  }
}
