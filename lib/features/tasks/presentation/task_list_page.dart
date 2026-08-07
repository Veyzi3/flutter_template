import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/page_layout.dart';
import '../domain/task_item.dart';
import 'task_list_view_model.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListViewModelProvider);

    return PageLayout(
      title: '任务列表示例',
      subtitle: '完整展示 Repository、ViewModel 与异步 View 的协作方式。',
      actions: [
        IconButton.filledTonal(
          onPressed: () =>
              ref.read(taskListViewModelProvider.notifier).refresh(),
          tooltip: '刷新任务',
          icon: const Icon(Icons.refresh),
        ),
        FilledButton.icon(
          onPressed: () => _showAddTaskDialog(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('新建任务'),
        ),
      ],
      child: tasks.when(
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(48),
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => _ErrorState(
          message: error.toString(),
          onRetry: () => ref.read(taskListViewModelProvider.notifier).refresh(),
        ),
        data: (items) => _TaskList(
          items: items,
          onToggle: (id) =>
              ref.read(taskListViewModelProvider.notifier).toggleTask(id),
          onDelete: (id) =>
              ref.read(taskListViewModelProvider.notifier).deleteTask(id),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context, WidgetRef ref) async {
    final title = await showDialog<String>(
      context: context,
      builder: (context) => const _AddTaskDialog(),
    );

    if (title != null && title.trim().isNotEmpty) {
      await ref.read(taskListViewModelProvider.notifier).addTask(title);
    }
  }
}

class _AddTaskDialog extends StatefulWidget {
  const _AddTaskDialog();

  @override
  State<_AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<_AddTaskDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新建任务'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: '任务名称',
          hintText: '例如：接入真实 REST API',
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(onPressed: _submit, child: const Text('创建')),
      ],
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({
    required this.items,
    required this.onToggle,
    required this.onDelete,
  });

  final List<TaskItem> items;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: const Center(child: Text('暂无任务，创建一条试试。')),
        ),
      );
    }

    return Card(
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _TaskTile(
              item: items[index],
              onToggle: () => onToggle(items[index].id),
              onDelete: () => onDelete(items[index].id),
            ),
            if (index != items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  final TaskItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 72,
      leading: Checkbox(value: item.isCompleted, onChanged: (_) => onToggle()),
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
          color: item.isCompleted
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : null,
        ),
      ),
      subtitle: Text(item.isCompleted ? '已完成' : '待处理'),
      trailing: IconButton(
        onPressed: onDelete,
        tooltip: '删除任务',
        color: context.semanticColors.warning,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: context.spacing.sm),
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: context.spacing.md),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }
}
