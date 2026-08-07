// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Hale Flutter 模板';

  @override
  String get navDashboard => '概览';

  @override
  String get navTasks => '任务示例';

  @override
  String get navAbout => '工程说明';

  @override
  String get navSettings => '设置';

  @override
  String get dashboardTitle => '工程概览';

  @override
  String get dashboardSubtitle => '一套可运行、可测试、便于团队和 AI 持续扩展的 Flutter 模板。';

  @override
  String get architecturePattern => '架构模式';

  @override
  String get featureFirstDetail => '按业务功能垂直切分';

  @override
  String get sampleTasks => '示例任务';

  @override
  String completedTaskCount(int count) {
    return '$count 条已完成';
  }

  @override
  String get themeMode => '主题模式';

  @override
  String get themeModeCount => '3';

  @override
  String get themeModeDetail => '系统 / 亮色 / 暗色';

  @override
  String get coreDependencies => '核心依赖';

  @override
  String get clearResponsibilities => '均有明确职责边界';

  @override
  String get getStarted => '开始使用';

  @override
  String get tryMvvm => '体验 MVVM';

  @override
  String get tryMvvmSubtitle => '查看异步任务增删改';

  @override
  String get understandArchitecture => '理解架构';

  @override
  String get understandArchitectureSubtitle => '查看依赖与目录职责';

  @override
  String get switchTheme => '切换主题';

  @override
  String get switchThemeSubtitle => '验证主题持久化';

  @override
  String get aiReadyDescription => '仓库根目录的 AGENTS.md 是 AI 开发的统一入口。';

  @override
  String get tasksTitle => '任务列表示例';

  @override
  String get tasksSubtitle => '完整展示 Repository、ViewModel 与异步 View 的协作方式。';

  @override
  String get refreshTasks => '刷新任务';

  @override
  String get newTask => '新建任务';

  @override
  String get taskName => '任务名称';

  @override
  String get taskNameHint => '例如：接入真实 REST API';

  @override
  String get cancel => '取消';

  @override
  String get create => '创建';

  @override
  String get emptyTasks => '暂无任务，创建一条试试。';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待处理';

  @override
  String get deleteTask => '删除任务';

  @override
  String get retry => '重试';

  @override
  String get aboutTitle => '工程说明';

  @override
  String get aboutSubtitle => '依赖保持精简，每个包只解决一个清晰问题。';

  @override
  String get mvvmDataFlow => 'MVVM 数据流';

  @override
  String get domainInterface => '领域接口';

  @override
  String get stateAndDi => '状态管理与依赖注入';

  @override
  String get riverpodReason => '让 ViewModel 可测试、依赖可替换，并统一同步/异步状态表达。';

  @override
  String get declarativeRouting => '声明式路由';

  @override
  String get goRouterReason => '支持深链、Web URL 与嵌套路由，ShellRoute 统一承载自适应导航。';

  @override
  String get httpClient => 'HTTP 客户端';

  @override
  String get dioReason => '提供拦截器、超时、取消请求和灵活适配器，便于建设统一网络层。';

  @override
  String get lightweightSettings => '轻量本地配置';

  @override
  String get sharedPreferencesReason =>
      '使用 SharedPreferencesAsync 保存主题、语言等非敏感偏好。';

  @override
  String get aiDevelopmentSupport => 'AI 开发支持';

  @override
  String get aiDevelopmentDescription =>
      'AGENTS.md 提供架构地图、分层约束、命令和完成标准；CLAUDE.md 复用同一规则源。';

  @override
  String get settingsTitle => '偏好设置';

  @override
  String get settingsSubtitle => '主题和语言选择会持久化，重启应用后仍然生效。';

  @override
  String get themeSectionDescription =>
      'ColorScheme 负责 Material 角色色，业务状态色由 ThemeExtension 提供。';

  @override
  String get systemTheme => '跟随系统';

  @override
  String get lightTheme => '亮色';

  @override
  String get darkTheme => '暗色';

  @override
  String get language => '语言';

  @override
  String get languageDescription => '跟随系统，或为应用选择固定显示语言。';

  @override
  String get systemLanguage => '跟随系统';

  @override
  String get chinese => '中文';

  @override
  String get english => 'English';

  @override
  String get semanticColors => '语义颜色';

  @override
  String get success => '成功';

  @override
  String get warning => '警告';

  @override
  String get info => '信息';

  @override
  String get error => '错误';
}
