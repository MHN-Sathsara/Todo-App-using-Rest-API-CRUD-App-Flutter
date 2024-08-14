import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/view/screens/add_page.dart';
import 'package:get/get.dart';

//utils
import 'package:todo_app/utils/themes/colorsp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 90.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
        ),
        backgroundColor: kBlueAccent,
        // centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'My Todos',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded, color: Colors.white),
          onPressed: () => _showLogoutDialog(context),
        ),
        elevation: 5.0,
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddTodoPage());
        },
        backgroundColor: kBlueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        children: [
          _messagesListView(),
        ],
      ),
    );
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.60,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getTodos(),
        builder: (context, snapshot) {
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'Nothing on Your todo lsit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index].data();
              String todoId = todos[index].id;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Text('${index + 1}')),
                  tileColor: Colors.lightBlue[100],
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Checkbox(
                    value: todo.is_Completed,
                    onChanged: (value) {
                      Todo updatedTodo = todo.copyWith(
                        is_Completed: !todo.is_Completed,
                      );
                      _databaseService.updateTodo(todoId, updatedTodo);
                    },
                  ),
                  onLongPress: () {
                    _showDeleteConfirmationDialog(todoId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(String todoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: const Text('Do you want to edit or delete this todo?'),
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
                'Edit',
                style: TextStyle(color: kBlueAccent),
              ),
              onPressed: () {},
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: kBlueAccent),
              ),
              onPressed: () {
                _databaseService.deleteTodo(todoId);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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
