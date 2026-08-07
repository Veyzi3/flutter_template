import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/page_layout.dart';
import '../../../core/widgets/status_badge.dart';
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
      title: '工程概览',
      subtitle: '一套可运行、可测试、便于团队和 AI 持续扩展的 Flutter 模板。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MetricGrid(
            items: [
              _Metric(
                label: '架构模式',
                value: 'MVVM',
                detail: '按业务功能垂直切分',
                icon: Icons.layers_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              _Metric(
                label: '示例任务',
                value: taskCount?.toString() ?? '...',
                detail: '${completedCount ?? 0} 条已完成',
                icon: Icons.checklist,
                color: context.semanticColors.success,
              ),
              _Metric(
                label: '主题模式',
                value: '3',
                detail: '系统 / 亮色 / 暗色',
                icon: Icons.palette_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              _Metric(
                label: '核心依赖',
                value: '4',
                detail: '均有明确职责边界',
                icon: Icons.extension_outlined,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
          SizedBox(height: context.spacing.lg),
          Text('开始使用', style: Theme.of(context).textTheme.titleLarge),
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
                    title: '体验 MVVM',
                    subtitle: '查看异步任务增删改',
                    onTap: () => context.go(AppRoutes.tasks),
                  ),
                  _ActionItem(
                    icon: Icons.account_tree_outlined,
                    title: '理解架构',
                    subtitle: '查看依赖与目录职责',
                    onTap: () => context.go(AppRoutes.about),
                  ),
                  _ActionItem(
                    icon: Icons.contrast,
                    title: '切换主题',
                    subtitle: '验证主题持久化',
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
              const Expanded(child: Text('仓库根目录的 AGENTS.md 是 AI 开发的统一入口。')),
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
