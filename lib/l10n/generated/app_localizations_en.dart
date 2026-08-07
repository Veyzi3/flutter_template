// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hale Flutter Template';

  @override
  String get navDashboard => 'Overview';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navAbout => 'Architecture';

  @override
  String get navSettings => 'Settings';

  @override
  String get dashboardTitle => 'Project overview';

  @override
  String get dashboardSubtitle =>
      'A runnable and testable Flutter template built for teams and AI-assisted development.';

  @override
  String get architecturePattern => 'Architecture';

  @override
  String get featureFirstDetail => 'Feature-first vertical slices';

  @override
  String get sampleTasks => 'Sample tasks';

  @override
  String completedTaskCount(int count) {
    return '$count completed';
  }

  @override
  String get themeMode => 'Theme modes';

  @override
  String get themeModeCount => '3';

  @override
  String get themeModeDetail => 'System / Light / Dark';

  @override
  String get coreDependencies => 'Core packages';

  @override
  String get clearResponsibilities => 'Each has a clear boundary';

  @override
  String get getStarted => 'Get started';

  @override
  String get tryMvvm => 'Try MVVM';

  @override
  String get tryMvvmSubtitle => 'Add, update, and delete async tasks';

  @override
  String get understandArchitecture => 'Explore architecture';

  @override
  String get understandArchitectureSubtitle =>
      'Review dependencies and directory roles';

  @override
  String get switchTheme => 'Switch theme';

  @override
  String get switchThemeSubtitle => 'Verify persisted preferences';

  @override
  String get aiReadyDescription =>
      'AGENTS.md at the repository root is the source of truth for AI development.';

  @override
  String get tasksTitle => 'Task list example';

  @override
  String get tasksSubtitle =>
      'A complete Repository, ViewModel, and asynchronous View workflow.';

  @override
  String get refreshTasks => 'Refresh tasks';

  @override
  String get newTask => 'New task';

  @override
  String get taskName => 'Task name';

  @override
  String get taskNameHint => 'For example: Connect a REST API';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get emptyTasks => 'No tasks yet. Create one to get started.';

  @override
  String get completed => 'Completed';

  @override
  String get pending => 'Pending';

  @override
  String get deleteTask => 'Delete task';

  @override
  String get retry => 'Retry';

  @override
  String get aboutTitle => 'Architecture';

  @override
  String get aboutSubtitle =>
      'A focused dependency set where every package solves one clear problem.';

  @override
  String get mvvmDataFlow => 'MVVM data flow';

  @override
  String get domainInterface => 'Domain interface';

  @override
  String get stateAndDi => 'State management and dependency injection';

  @override
  String get riverpodReason =>
      'Keeps ViewModels testable, dependencies replaceable, and sync/async state consistent.';

  @override
  String get declarativeRouting => 'Declarative routing';

  @override
  String get goRouterReason =>
      'Supports deep links, web URLs, nested routes, and adaptive navigation through ShellRoute.';

  @override
  String get httpClient => 'HTTP client';

  @override
  String get dioReason =>
      'Provides interceptors, timeouts, cancellation, and adapters for a consistent network layer.';

  @override
  String get lightweightSettings => 'Lightweight local settings';

  @override
  String get sharedPreferencesReason =>
      'Stores non-sensitive preferences such as theme and language with SharedPreferencesAsync.';

  @override
  String get aiDevelopmentSupport => 'AI development support';

  @override
  String get aiDevelopmentDescription =>
      'AGENTS.md defines the architecture map, boundaries, commands, and completion criteria; CLAUDE.md reuses the same source.';

  @override
  String get settingsTitle => 'Preferences';

  @override
  String get settingsSubtitle =>
      'Theme and language choices persist across app restarts.';

  @override
  String get themeSectionDescription =>
      'ColorScheme owns Material color roles while ThemeExtension provides semantic status colors.';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get languageDescription =>
      'Follow the system language or choose a fixed app language.';

  @override
  String get systemLanguage => 'System';

  @override
  String get chinese => '中文';

  @override
  String get english => 'English';

  @override
  String get semanticColors => 'Semantic colors';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Info';

  @override
  String get error => 'Error';
}
