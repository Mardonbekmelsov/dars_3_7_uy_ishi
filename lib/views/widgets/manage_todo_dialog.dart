import 'package:dars_3_7_uy_ishi/models/todo.dart';
import 'package:flutter/material.dart';

class ManageTodoDialog extends StatefulWidget {
  final Todo? todo;
  const ManageTodoDialog({
    super.key,
    this.todo,
  });

  @override
  State<ManageTodoDialog> createState() => _ManageTodoDialogState();
}

class _ManageTodoDialogState extends State<ManageTodoDialog> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String data = "";

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      title = widget.todo!.title;
      data = widget.todo!.data;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
        "data": data,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.todo != null ? "Rejani tahrirlash" : "Reja qo'shish",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reja nomini kiriting",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos reja nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: data,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reja sanasini kiriting",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos rejaning vaqtini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                data = newValue!;
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
