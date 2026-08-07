import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    _Destination(
      label: '概览',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      path: AppRoutes.dashboard,
    ),
    _Destination(
      label: '任务示例',
      icon: Icons.checklist_outlined,
      selectedIcon: Icons.checklist,
      path: AppRoutes.tasks,
    ),
    _Destination(
      label: '工程说明',
      icon: Icons.account_tree_outlined,
      selectedIcon: Icons.account_tree,
      path: AppRoutes.about,
    ),
    _Destination(
      label: '设置',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      path: AppRoutes.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final selectedIndex = _indexForPath(path);

    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 840;
        final extendRail = constraints.maxWidth >= 1180;

        return Scaffold(
          body: Row(
            children: [
              if (useRail)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  extended: extendRail,
                  minExtendedWidth: 220,
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.layers_rounded),
                        if (extendRail) ...[
                          const SizedBox(width: 12),
                          Text(
                            'Hale Template',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                  onDestinationSelected: (index) =>
                      context.go(_destinations[index].path),
                  destinations: [
                    for (final destination in _destinations)
                      NavigationRailDestination(
                        icon: Icon(destination.icon),
                        selectedIcon: Icon(destination.selectedIcon),
                        label: Text(destination.label),
                      ),
                  ],
                ),
              Expanded(child: child),
            ],
          ),
          bottomNavigationBar: useRail
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) =>
                      context.go(_destinations[index].path),
                  destinations: [
                    for (final destination in _destinations)
                      NavigationDestination(
                        icon: Icon(destination.icon),
                        selectedIcon: Icon(destination.selectedIcon),
                        label: destination.label,
                      ),
                  ],
                ),
        );
      },
    );
  }

  int _indexForPath(String path) {
    final index = _destinations.indexWhere((item) => item.path == path);
    return index < 0 ? 0 : index;
  }
}

class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String path;
}
