import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/services/auth_service.dart';
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.logout_rounded, color: Colors.black),
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ),
      body: Obx(() {
        if (todoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: todoController.fetchTodos,
            child: ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                final item = todoController.todos[index] as Map;
                final id = item['_id'] as String;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // edit
                        navigateToEditPage(context, item);
                      } else if (value == 'delete') {
                        // delete
                        todoController.deleteById(id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                            value: 'delete', child: Text('Delete')),
                      ];
                    },
                  ),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddTodoPage(context);
        },
        label: const Text('Add Todo'),
      ),
    );
  }

  Future<void> navigateToEditPage(BuildContext context, Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    final TodoController todoController = Get.find();
    todoController.fetchTodos();
  }

  Future<void> navigateToAddTodoPage(BuildContext context) async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
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
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await AuthService().signout(context: context);
                  // Navigator.of(context).pop(); // Close the dialog
                  // Navigator.of(context).pop(); // Navigate back
                  // Add your logout logic here if needed
                },
              ),
            ],
          );
        });
  }
}
