import 'task_item.dart';

abstract interface class TaskRepository {
  Future<List<TaskItem>> fetchTasks();
  Future<TaskItem> addTask(String title);
  Future<void> toggleTask(String id);
  Future<void> deleteTask(String id);
}
