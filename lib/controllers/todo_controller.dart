import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TodoController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final dio = Dio();

  static const String _url = 'https://api.nstack.in/v1/todos';
  static const String _fetchErrorMessage = 'Failed to fetch data';
  static const String _deleteErrorMessage = 'Failed to delete todo';
  static const String _deleteSuccessMessage = 'Todo Deleted Successfully';

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
        Get.snackbar('Success', _deleteSuccessMessage,
            backgroundColor: Colors.green);
      } else {
        _handleError(response.statusCode, _deleteErrorMessage);
      }
    } on DioException catch (e) {
      _handleError(e, _deleteErrorMessage);
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
