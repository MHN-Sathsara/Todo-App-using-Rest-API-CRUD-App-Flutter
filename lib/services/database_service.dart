import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';

const String TODO_COLLECTION_REF = 'todos';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
          fromFirestore: (snapshots, _) => Todo.fromJson(
            snapshots.data()!,
          ),
          toFirestore: (todo, _) => todo.toJson(),
        );
  }

  Stream<QuerySnapshot> getTodos() {
    return _todosRef.snapshots();
  }

  void addTodo(Todo todo) async {
    _todosRef.add(todo);
  }

  void updateTodo(String todoId, Todo todo) async {
    _todosRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) async {
    _todosRef.doc(todoId).delete();
  }
}
