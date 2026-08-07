import 'package:flutter/foundation.dart';

@immutable
class TaskItem {
  const TaskItem({
    required this.id,
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final bool isCompleted;

  TaskItem copyWith({String? title, bool? isCompleted}) {
    return TaskItem(
      id: id,
      title: title ?? this.title,
      createdAt: createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
