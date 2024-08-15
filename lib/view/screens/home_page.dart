import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database_service.dart';

//utils
import 'package:todo_app/utils/themes/colorsp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
        backgroundColor: Colors.black,
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
        onPressed: _displayTextimputDialog,
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
          print(todos);
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
                  tileColor: Colors.grey[500],
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
          title: const Text('Todos ?'),
          content: const Text('Do you want to edit or delete this todo?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: kBlueAccent),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pop();
                  _displayTextimputDialog(todoID: todoId);
                }),
            IconButton(
              icon: const Icon(Icons.delete),
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
                // await AuthService().signOut(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _displayTextimputDialog(
      {String? todoID,
      String? existingTitle,
      String? existingDescription}) async {
    // Initialize controllers with existing data if editing
    _titleEditingController.text = existingTitle ?? '';
    _descriptionController.text = existingDescription ?? '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(todoID == null ? 'Add Todo' : 'Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter Todo ',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Todo Description',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              color: kBlueAccent,
              textColor: Colors.white,
              child: const Text('Ok'),
              onPressed: () {
                if (todoID == null) {
                  // Add new Todo
                  Todo todo = Todo(
                    title: _titleEditingController.text,
                    description: _descriptionController.text,
                    is_Completed: false,
                  );
                  _databaseService.addTodo(todo);
                } else {
                  // Update existing Todo
                  Todo todo = Todo(
                    title: _titleEditingController.text,
                    description: _descriptionController.text,
                    is_Completed: false,
                  );
                  _databaseService.updateTodo(todoID, todo);
                }
                Navigator.of(context).pop(); // Close the dialog
                _titleEditingController.clear(); // Clear text fields
                _descriptionController.clear();
              },
            ),
            MaterialButton(
              color: Colors.grey,
              textColor: Colors.white,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _titleEditingController.clear(); // Clear text fields
                _descriptionController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
