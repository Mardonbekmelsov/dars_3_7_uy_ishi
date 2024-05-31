import 'dart:convert';

import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoHttpService {
  Future<List<Todo>> getTodos() async {
    Uri url = Uri.parse(
        "https://dars-f31ed-default-rtdb.asia-southeast1.firebasedatabase.app/todos.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    List<Todo> loadedTodos = [];

    if (data != null) {
      data.forEach((key, value) {
        value["id"] = key;
        loadedTodos.add(Todo.fromJson(value));
      });
    }
    return loadedTodos;
  }

  Future<Todo> addTodo(String title, String data) async {
    Uri url = Uri.parse(
        "https://dars-f31ed-default-rtdb.asia-southeast1.firebasedatabase.app/todos.json");
    Map<String, dynamic> todoData = {
      "title": title,
      "data": data,
      "isCompleted": false
    };
    final response = await http.post(url, body: jsonEncode(todoData));

    final data1 = jsonDecode(response.body);
    todoData["id"] = data1["name"];
    Todo newTodo = Todo.fromJson(todoData);
    return newTodo;
  }

  Future<void> deleteTodo(String id) async {
    Uri url = Uri.parse(
        "https://dars-f31ed-default-rtdb.asia-southeast1.firebasedatabase.app/todos/$id.json");
    await http.delete(url);
  }

  Future<void> editTodo(
    String id,
    String newTitle,
    String newData,
  ) async {
    Uri url = Uri.parse(
        "https://dars-f31ed-default-rtdb.asia-southeast1.firebasedatabase.app/todos/$id.json");

    Map<String, dynamic> todoData = {
      "title": newTitle,
      "data": newData,
    };
    final response = await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> changePosition(String id, bool isCompleted) async {
    Uri url = Uri.parse(
        "https://dars-f31ed-default-rtdb.asia-southeast1.firebasedatabase.app/todos/$id.json");
    Map<String, dynamic> todoData = {"isCompleted": isCompleted};
    final response = await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }
}
