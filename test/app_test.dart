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
}
