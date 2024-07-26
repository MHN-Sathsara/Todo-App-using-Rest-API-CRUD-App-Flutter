import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
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
                            value: 'delete',
                            child: Text('Delete')),
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
}
