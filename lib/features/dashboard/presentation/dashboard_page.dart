import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/page_layout.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/l10n.dart';
import '../../tasks/presentation/task_list_view_model.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListViewModelProvider);
    final taskCount = tasks.value?.length;
    final completedCount = tasks.value
        ?.where((item) => item.isCompleted)
        .length;

    return PageLayout(
      title: context.l10n.dashboardTitle,
      subtitle: context.l10n.dashboardSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MetricGrid(
            items: [
              _Metric(
                label: context.l10n.architecturePattern,
                value: 'MVVM',
                detail: context.l10n.featureFirstDetail,
                icon: Icons.layers_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              _Metric(
                label: context.l10n.sampleTasks,
                value: taskCount?.toString() ?? '...',
                detail: context.l10n.completedTaskCount(completedCount ?? 0),
                icon: Icons.checklist,
                color: context.semanticColors.success,
              ),
              _Metric(
                label: context.l10n.themeMode,
                value: context.l10n.themeModeCount,
                detail: context.l10n.themeModeDetail,
                icon: Icons.palette_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              _Metric(
                label: context.l10n.coreDependencies,
                value: '4',
                detail: context.l10n.clearResponsibilities,
                icon: Icons.extension_outlined,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
          SizedBox(height: context.spacing.lg),
          Text(
            context.l10n.getStarted,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: context.spacing.md),
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: Wrap(
                spacing: context.spacing.md,
                runSpacing: context.spacing.md,
                children: [
                  _ActionItem(
                    icon: Icons.playlist_add_check,
                    title: context.l10n.tryMvvm,
                    subtitle: context.l10n.tryMvvmSubtitle,
                    onTap: () => context.go(AppRoutes.tasks),
                  ),
                  _ActionItem(
                    icon: Icons.account_tree_outlined,
                    title: context.l10n.understandArchitecture,
                    subtitle: context.l10n.understandArchitectureSubtitle,
                    onTap: () => context.go(AppRoutes.about),
                  ),
                  _ActionItem(
                    icon: Icons.contrast,
                    title: context.l10n.switchTheme,
                    subtitle: context.l10n.switchThemeSubtitle,
                    onTap: () => context.go(AppRoutes.settings),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Row(
            children: [
              StatusBadge(
                label: 'AI READY',
                color: context.semanticColors.info,
                foregroundColor: context.semanticColors.onInfo,
              ),
              SizedBox(width: context.spacing.sm),
              Expanded(child: Text(context.l10n.aiReadyDescription)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.items});

  final List<_Metric> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 560
            ? 2
            : 1;
        final width =
            (constraints.maxWidth - context.spacing.md * (columns - 1)) /
            columns;

        return Wrap(
          spacing: context.spacing.md,
          runSpacing: context.spacing.md,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: _MetricCard(item: item),
              ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.item});

  final _Metric item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: Row(
          children: [
            Icon(item.icon, color: item.color, size: 28),
            SizedBox(width: context.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    item.detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _Metric {
  const _Metric({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;
}
