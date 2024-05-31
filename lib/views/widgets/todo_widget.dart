import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoWidget extends StatelessWidget {
  Todo todo;
  final Function() onDelete;
  final Function() onEdit;
  final Function() changePosition;

  TodoWidget(
      {super.key,
      required this.todo,
      required this.onDelete,
      required this.onEdit,
      required this.changePosition});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changePosition,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration:
                        todo.isCompleted ? TextDecoration.lineThrough : null,
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
                  onPressed: onEdit,
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
      ),
    );
  }
}
