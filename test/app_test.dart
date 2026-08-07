import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/features/tasks/data/in_memory_task_repository.dart';
import 'package:flutter_template/features/tasks/presentation/task_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on the dashboard', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskRepositoryProvider.overrideWithValue(
            InMemoryTaskRepository(fetchDelay: Duration.zero),
          ),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('工程概览'), findsWidgets);
  });

  testWidgets('creates a task from the dialog without focus errors', (
    tester,
  ) async {
    final repository = InMemoryTaskRepository(
      seed: [],
      fetchDelay: Duration.zero,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [taskRepositoryProvider.overrideWithValue(repository)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.checklist_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('新建任务'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '验证保存');
    await tester.tap(find.text('创建'));
    await tester.pumpAndSettle();

    expect(find.text('验证保存'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
