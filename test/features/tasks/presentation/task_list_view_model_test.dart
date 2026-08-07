import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/tasks/data/in_memory_task_repository.dart';
import 'package:flutter_template/features/tasks/presentation/task_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizes and adds a task', () async {
    final repository = InMemoryTaskRepository(
      seed: [],
      fetchDelay: Duration.zero,
    );
    final container = ProviderContainer(
      overrides: [taskRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(taskListViewModelProvider.future);
    await container.read(taskListViewModelProvider.notifier).addTask('  新任务  ');

    final tasks = container.read(taskListViewModelProvider).requireValue;
    expect(tasks.single.title, '新任务');
  });

  test('ignores a blank task title', () async {
    final repository = InMemoryTaskRepository(
      seed: [],
      fetchDelay: Duration.zero,
    );
    final container = ProviderContainer(
      overrides: [taskRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(taskListViewModelProvider.future);
    await container.read(taskListViewModelProvider.notifier).addTask('   ');

    expect(container.read(taskListViewModelProvider).requireValue, isEmpty);
  });
}
