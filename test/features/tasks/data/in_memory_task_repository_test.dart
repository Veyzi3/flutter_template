import 'package:flutter_template/features/tasks/data/in_memory_task_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InMemoryTaskRepository repository;

  setUp(() {
    repository = InMemoryTaskRepository(
      seed: [],
      now: () => DateTime(2026, 8, 7, 10),
      fetchDelay: Duration.zero,
    );
  });

  test('supports the task lifecycle', () async {
    final created = await repository.addTask('发布模板');
    expect((await repository.fetchTasks()).single.title, '发布模板');

    await repository.toggleTask(created.id);
    expect((await repository.fetchTasks()).single.isCompleted, isTrue);

    await repository.deleteTask(created.id);
    expect(await repository.fetchTasks(), isEmpty);
  });

  test('returns an immutable task list', () async {
    await repository.addTask('test');
    final tasks = await repository.fetchTasks();

    expect(() => tasks.clear(), throwsUnsupportedError);
  });
}
