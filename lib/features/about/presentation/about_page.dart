import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/page_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _dependencies = [
    _Dependency(
      name: 'flutter_riverpod',
      version: '^3.4.2',
      role: '状态管理与依赖注入',
      reason: '让 ViewModel 可测试、依赖可替换，并统一同步/异步状态表达。',
    ),
    _Dependency(
      name: 'go_router',
      version: '^17.4.0',
      role: '声明式路由',
      reason: '支持深链、Web URL 与嵌套路由，ShellRoute 统一承载自适应导航。',
    ),
    _Dependency(
      name: 'dio',
      version: '^5.11.0',
      role: 'HTTP 客户端',
      reason: '提供拦截器、超时、取消请求和灵活适配器，便于建设统一网络层。',
    ),
    _Dependency(
      name: 'shared_preferences',
      version: '^2.5.5',
      role: '轻量本地配置',
      reason: '使用 SharedPreferencesAsync 保存主题等非敏感偏好，避免旧缓存 API。',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: '工程说明',
      subtitle: '依赖保持精简，每个包只解决一个清晰问题。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MVVM 数据流', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: context.spacing.md),
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: const _ArchitectureFlow(),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Text('核心依赖', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: context.spacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 760 ? 2 : 1;
              final width =
                  (constraints.maxWidth - context.spacing.md * (columns - 1)) /
                  columns;
              return Wrap(
                spacing: context.spacing.md,
                runSpacing: context.spacing.md,
                children: [
                  for (final dependency in _dependencies)
                    SizedBox(
                      width: width,
                      child: _DependencyCard(dependency: dependency),
                    ),
                ],
              );
            },
          ),
          SizedBox(height: context.spacing.lg),
          Card(
            child: ListTile(
              leading: const Icon(Icons.smart_toy_outlined),
              title: const Text('AI 开发支持'),
              subtitle: const Text(
                'AGENTS.md 提供架构地图、分层约束、命令和完成标准；CLAUDE.md 与 Copilot 指令复用同一规则源。',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchitectureFlow extends StatelessWidget {
  const _ArchitectureFlow();

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('View', 'ConsumerWidget'),
      ('ViewModel', 'Notifier / AsyncNotifier'),
      ('Repository', '领域接口'),
      ('Data Source', 'Dio / Local Storage'),
    ];

    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var index = 0; index < steps.length; index++) ...[
          Chip(
            avatar: CircleAvatar(child: Text('${index + 1}')),
            label: Text('${steps[index].$1}\n${steps[index].$2}'),
          ),
          if (index != steps.length - 1)
            const Icon(Icons.arrow_forward, size: 18),
        ],
      ],
    );
  }
}

class _DependencyCard extends StatelessWidget {
  const _DependencyCard({required this.dependency});

  final _Dependency dependency;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    dependency.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  dependency.version,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: context.spacing.xs),
            Text(
              dependency.role,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: context.spacing.sm),
            Text(dependency.reason),
          ],
        ),
      ),
    );
  }
}

class _Dependency {
  const _Dependency({
    required this.name,
    required this.version,
    required this.role,
    required this.reason,
  });

  final String name;
  final String version;
  final String role;
  final String reason;
}
