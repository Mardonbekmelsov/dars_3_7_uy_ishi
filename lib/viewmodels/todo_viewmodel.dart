import 'dart:async';

import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:dars_3_7_uy_ishi/repositories/todos_repository.dart';

class TodoViewmodel {
  final todosRepository = TodosRepository();

  List<Todo> _todos = [];

  Future<List<Todo>> get todos async {
    _todos = await todosRepository.getTodos();
    return [..._todos];
  }

  void addTodo(String title, String data) async {
    final newTodo = await todosRepository.addTodo(title, data);
    _todos.add(newTodo);
  }

  Future<void> deleteTodo(String id) async {
    await todosRepository.deleteTodo(id);
    _todos.removeWhere((product) => product.id == id);
  }
}
