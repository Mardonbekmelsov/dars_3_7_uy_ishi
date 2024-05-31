import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:dars_3_7_uy_ishi/services/todo_http_service.dart';

class TodosRepository {
  final todoHttpService = TodoHttpService();

  Future<List<Todo>> getTodos() async {
    return todoHttpService.getTodos();
  }

  Future<Todo> addTodo(String title, String data) async {
    final newTodo = await todoHttpService.addTodo(title, data);
    return newTodo;
  }

  Future<void> deleteTodo(String id) async {
    await todoHttpService.deleteTodo(id);
  }

  Future<void> editTodo(String id, String newTitle, String newData) async {
    await todoHttpService.editTodo(id, newTitle, newData);
  }

  Future<void> changePosition(String id, bool isCompleted) async {
    await todoHttpService.changePosition(id, isCompleted);
  }   
}
