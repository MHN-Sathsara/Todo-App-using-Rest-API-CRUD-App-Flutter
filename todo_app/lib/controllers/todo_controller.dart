import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final dio = Dio();
  Box? todoBox;

  static const String _url = 'https://api.nstack.in/v1/todos';
  static const String _fetchErrorMessage = 'Failed to fetch data';
  static const String _deleteErrorMessage = 'Failed to delete todo';
  static const String _deleteSuccessMessage = 'Todo Deleted Successfully';

  @override
  void onInit() {
    super.onInit();
    todoBox = Hive.box('todos');
    fetchTodosFromLocal(); // Fetch local todos first
  }

  @override
  void onReady() {
    super.onReady();
    fetchTodos(); // Fetch online todos after the widget is ready
  }

  Future<void> fetchTodos() async {
    if (isLoading.value) return;
    isLoading(true);

    try {
      final response = await dio.get(_url);
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final result = json['items'] as List;
        todos.assignAll(result.cast<Map<String, dynamic>>());
        await _saveTodosToLocal(result);
      } else {
        _handleError(response.statusCode, _fetchErrorMessage);
      }
    } on DioException catch (e) {
      _handleError(e, _fetchErrorMessage);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteById(String id) async {
    final url = '$_url/$id';

    try {
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        todos.removeWhere((item) => item['_id'] == id);
        await _saveTodosToLocal(todos);
        Get.snackbar('Success', _deleteSuccessMessage,
            backgroundColor: Colors.green);
      } else {
        _handleError(response.statusCode, _deleteErrorMessage);
      }
    } on DioException catch (e) {
      _handleError(e, _deleteErrorMessage);
    }
  }

  Future<void> _saveTodosToLocal(List todos) async {
    await todoBox?.put('todos', todos);
  }

  Future<void> fetchTodosFromLocal() async {
    final localTodos = todoBox?.get('todos');

    if (localTodos != null && localTodos is List) {
      try {
        todos.assignAll(
            localTodos.map((item) => Map<String, dynamic>.from(item)).toList());
      } catch (e) {
        Get.snackbar('Error', 'Failed to load local todos',
            backgroundColor: Colors.red);
      }
    }
  }

  void _handleError(dynamic error, String defaultErrorMessage) {
    String errorMessage = defaultErrorMessage;

    if (error is DioException && error.response != null) {
      errorMessage = error.response?.data['message'] ?? defaultErrorMessage;
    } else if (error is DioException) {
      errorMessage = error.message?.isNotEmpty == true
          ? error.message!
          : defaultErrorMessage;
    }

    Get.snackbar('Error', errorMessage, backgroundColor: Colors.red);
  }
}
