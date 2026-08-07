import '../domain/task_item.dart';
import '../domain/task_repository.dart';

class InMemoryTaskRepository implements TaskRepository {
  InMemoryTaskRepository({
    List<TaskItem>? seed,
    DateTime Function()? now,
    this.fetchDelay = const Duration(milliseconds: 250),
  }) : _items = List.of(seed ?? _defaultItems),
       _now = now ?? DateTime.now;

  static final List<TaskItem> _defaultItems = [
    TaskItem(
      id: 'architecture',
      title: '阅读 docs/architecture.md',
      createdAt: DateTime(2026, 8, 6, 9),
      isCompleted: true,
    ),
    TaskItem(
      id: 'feature',
      title: '从 features/tasks 复制一个新功能骨架',
      createdAt: DateTime(2026, 8, 6, 9, 30),
    ),
  ];

  final List<TaskItem> _items;
  final DateTime Function() _now;
  final Duration fetchDelay;
  int _nextId = 0;

  @override
  Future<List<TaskItem>> fetchTasks() async {
    await Future<void>.delayed(fetchDelay);
    return List.unmodifiable(_items);
  }

  @override
  Future<TaskItem> addTask(String title) async {
    final createdAt = _now();
    final item = TaskItem(
      id: '${createdAt.microsecondsSinceEpoch}-${_nextId++}',
      title: title,
      createdAt: createdAt,
    );
    _items.insert(0, item);
    return item;
  }

  @override
  Future<void> toggleTask(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final item = _items[index];
    _items[index] = item.copyWith(isCompleted: !item.isCompleted);
  }

  @override
  Future<void> deleteTask(String id) async {
    _items.removeWhere((item) => item.id == id);
  }
}
