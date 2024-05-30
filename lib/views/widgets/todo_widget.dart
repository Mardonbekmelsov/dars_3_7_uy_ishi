import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoWidget extends StatelessWidget {
  Todo todo;
  final Function() onDelete;

  
  TodoWidget({super.key, required this.todo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                todo.data,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
