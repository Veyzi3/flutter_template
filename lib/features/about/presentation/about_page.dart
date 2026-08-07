import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/page_layout.dart';
import '../../../l10n/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  List<_Dependency> _dependencies(BuildContext context) => [
    _Dependency(
      name: 'flutter_riverpod',
      version: '^3.4.2',
      role: context.l10n.stateAndDi,
      reason: context.l10n.riverpodReason,
    ),
    _Dependency(
      name: 'go_router',
      version: '^17.4.0',
      role: context.l10n.declarativeRouting,
      reason: context.l10n.goRouterReason,
    ),
    _Dependency(
      name: 'dio',
      version: '^5.11.0',
      role: context.l10n.httpClient,
      reason: context.l10n.dioReason,
    ),
    _Dependency(
      name: 'shared_preferences',
      version: '^2.5.5',
      role: context.l10n.lightweightSettings,
      reason: context.l10n.sharedPreferencesReason,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final dependencies = _dependencies(context);
    return PageLayout(
      title: context.l10n.aboutTitle,
      subtitle: context.l10n.aboutSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.mvvmDataFlow,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: context.spacing.md),
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: const _ArchitectureFlow(),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Text(
            context.l10n.coreDependencies,
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
                  for (final dependency in dependencies)
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
              title: Text(context.l10n.aiDevelopmentSupport),
              subtitle: Text(context.l10n.aiDevelopmentDescription),
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
    final steps = [
      ('View', 'ConsumerWidget'),
      ('ViewModel', 'Notifier / AsyncNotifier'),
      ('Repository', context.l10n.domainInterface),
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
