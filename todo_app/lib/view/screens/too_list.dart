import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/themes/colorsp.dart';
import 'package:todo_app/view/screens/add_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded, color: Colors.black),
          onPressed: () => _showLogoutDialog(context),
        ),
      ),
      body: Obx(() {
        if (todoController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: kBlueAccent,
          ));
        } else if (todoController.todos.isEmpty) {
          return const Center(
            child: Text(
              "No todos available",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return RefreshIndicator(
            color: kBlueAccent,
            onRefresh: todoController.fetchTodos,
            child: ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                final item =
                    todoController.todos[index].cast<String, dynamic>();
                final id = item['_id'] as String;
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: kBlueAccent,
                      foregroundColor: Colors.white,
                      child: Text('${index + 1}')),
                  title: Text(
                    item['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item['description'] ?? 'No Description'),
                  trailing: _buildPopupMenu(context, item, id, todoController),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigateToAddTodoPage(context),
        label: const Text(
          'Add Todo',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: kButtonColor,
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenu(BuildContext context,
      Map<String, dynamic> item, String id, TodoController todoController) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          navigateToEditPage(context, item);
        } else if (value == 'delete') {
          todoController.deleteById(id);
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(value: 'edit', child: Text('Edit')),
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ];
      },
    );
  }

  Future<void> navigateToEditPage(
      BuildContext context, Map<String, dynamic> item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoPage(todo: item)),
    );
    final TodoController todoController = Get.find();
    todoController.fetchTodos();
  }

  Future<void> navigateToAddTodoPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoPage()),
    );
    final TodoController todoController = Get.find();
    todoController.fetchTodos();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: kBlueAccent),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: kBlueAccent),
              ),
              onPressed: () async {
                await AuthService().signOut(context);
              },
            ),
          ],
        );
      },
    );
  }
}
