import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_task_repository.dart';
import '../domain/task_item.dart';
import '../domain/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return InMemoryTaskRepository();
});

final taskListViewModelProvider =
    AsyncNotifierProvider<TaskListViewModel, List<TaskItem>>(
      TaskListViewModel.new,
    );

class TaskListViewModel extends AsyncNotifier<List<TaskItem>> {
  TaskRepository get _repository => ref.read(taskRepositoryProvider);

  @override
  Future<List<TaskItem>> build() {
    return ref.watch(taskRepositoryProvider).fetchTasks();
  }

  Future<void> addTask(String title) async {
    final normalized = title.trim();
    if (normalized.isEmpty) return;
    state = await AsyncValue.guard(() async {
      await _repository.addTask(normalized);
      return _repository.fetchTasks();
    });
  }

  Future<void> toggleTask(String id) async {
    state = await AsyncValue.guard(() async {
      await _repository.toggleTask(id);
      return _repository.fetchTasks();
    });
  }

  Future<void> deleteTask(String id) async {
    state = await AsyncValue.guard(() async {
      await _repository.deleteTask(id);
      return _repository.fetchTasks();
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.fetchTasks);
  }
}
