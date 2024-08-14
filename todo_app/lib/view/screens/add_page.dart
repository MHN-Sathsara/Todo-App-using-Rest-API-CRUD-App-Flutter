import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/utils/themes/colorsp.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo; // Use Todo model directly
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final DatabaseService _databaseService = DatabaseService();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  String? todoId; // Track todo ID for editing

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      todoId = todo.id; // Initialize todoId for editing
      titleController.text = todo.title;
      descriptionController.text = todo.description;
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
            onPressed: isEdit ? () => updateData() : () => submitData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shadowColor: Colors.black12,
              elevation: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    if (todoId == null) {
      Get.snackbar('Error', 'You cannot call update without todo ID',
          backgroundColor: Colors.red);
      return;
    }

    final updatedTodo = Todo(
      id: todoId!, // Ensure ID is preserved for updates
      title: titleController.text,
      description: descriptionController.text,
      is_Completed: widget.todo?.is_Completed ??
          false, // Preserve current completion status
    );

    try {
      _databaseService.updateTodo(todoId!, updatedTodo);

      titleController.text = '';
      descriptionController.text = '';
      Get.snackbar('Success', 'Update Success!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Navigator.of(context).pop(); // Close the page after updating
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  Future<void> submitData() async {
    final newTodo = Todo(
      title: titleController.text,
      description: descriptionController.text,
      is_Completed: false,
      id: '', // Leave empty for Firestore to handle ID generation
    );

    try {
      _databaseService.addTodo(newTodo);

      titleController.text = '';
      descriptionController.text = '';
      Get.snackbar('Success', 'Creation Success!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Navigator.of(context).pop(); // Close the page after adding
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit data',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }
}
