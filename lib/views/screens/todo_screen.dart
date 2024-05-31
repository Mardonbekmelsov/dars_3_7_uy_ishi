import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:dars_3_7_uy_ishi/viewmodels/todo_viewmodel.dart';
import 'package:dars_3_7_uy_ishi/views/widgets/manage_todo_dialog.dart';
import 'package:dars_3_7_uy_ishi/views/widgets/todo_widget.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final todoViewModel = TodoViewmodel();

  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageTodoDialog();
      },
    );

    if (data != null) {
      try {
        todoViewModel.addTodo(
          data['title'],
          data['data'],
        );
      } catch (e) {
        print(e);
      }
    }
    setState(() {});
  }

  void editTodo(Todo todo) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageTodoDialog(todo: todo);
      },
    );

    if (data != null) {
      todoViewModel.editTodo(
        todo.id,
        data['title'],
        data['data'],
      );
    }
    setState(() {});
  }

  void changePosition(Todo todo) async {
    todoViewModel.changePosition(todo.id, !todo.isCompleted);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: addTodo,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
            future: todoViewModel.todos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                print(snapshot.data);
                return const Center(
                  child: Text("Vazifalar mavjud emas"),
                );
              }
              final todos = snapshot.data;
              return todos == null || todos.isEmpty
                  ? const Center(
                      child: Text(
                        "Vazifalar yo'q",
                      ),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodoWidget(
                          todo: todo,
                          changePosition: () {
                            changePosition(todo);
                          },
                          onEdit: () {
                            editTodo(todo);
                          },
                          onDelete: () async {
                            final response = await showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("ishonchingiz komilmi?"),
                                  content: Text(
                                      "Siz ${todo.title} nomli rejani o'chirmoqchisiz."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text("Bekor qilish"),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text("Ha, ishonchim komil"),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (response) {
                              await todoViewModel.deleteTodo(todo.id);
                              setState(() {});
                            }
                          },
                        );
                      },
                    );
            }),
      ),
    );
  }
}
