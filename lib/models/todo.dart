import "package:json_annotation/json_annotation.dart";

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String title;
  String data;
  bool isCompleted;

  Todo(
      {
      required this.id,
      required this.title,
      required this.data,
      required this.isCompleted});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
