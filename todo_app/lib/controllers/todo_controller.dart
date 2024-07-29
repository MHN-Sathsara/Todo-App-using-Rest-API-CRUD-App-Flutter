import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TodoController extends GetxController {
  var todos = [].obs;
  var isLoading = false.obs;
  final dio = Dio();

  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  Future<void> fetchTodos() async {
    isLoading(true);
    const url = 'https://api.nstack.in/v1/todos';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final json = response.data as Map;
        final result = json['items'] as List;
        todos.assignAll(result);
      }
    } on DioException catch (e) {
      Get.snackbar('Error', 'Failed to fetch data',
          backgroundColor: Colors.red);
    }
    isLoading(false);
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';

    try {
      final response = await dio.delete(url); // Make a DELETE request using Dio

      if (response.statusCode == 200) {
        todos.removeWhere((item) => item['_id'] == id);
        Get.snackbar('Success', 'Todo Deleted Successfully',
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to delete todo',
            backgroundColor: Colors.red);
      }
    } on DioError catch (e) {
      // Handle Dio errors
      _handleError(e, 'Failed to delete todo');
    }
  }

  void _handleError(DioException e, String defaultErrorMessage) {
    if (e.response != null) {
      print('Error: ${e.response?.data}');
      print('Status code: ${e.response?.statusCode}');
      Get.snackbar('Error', e.response?.data['message'] ?? defaultErrorMessage,
          backgroundColor: Colors.red);
    } else {
      print('Error: ${e.message}');
      Get.snackbar('Error', defaultErrorMessage, backgroundColor: Colors.red);
    }
  }
}
