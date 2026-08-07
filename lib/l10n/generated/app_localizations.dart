import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'Hale Flutter 模板'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In zh, this message translates to:
  /// **'概览'**
  String get navDashboard;

  /// No description provided for @navTasks.
  ///
  /// In zh, this message translates to:
  /// **'任务示例'**
  String get navTasks;

  /// No description provided for @navAbout.
  ///
  /// In zh, this message translates to:
  /// **'工程说明'**
  String get navAbout;

  /// No description provided for @navSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get navSettings;

  /// No description provided for @dashboardTitle.
  ///
  /// In zh, this message translates to:
  /// **'工程概览'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'一套可运行、可测试、便于团队和 AI 持续扩展的 Flutter 模板。'**
  String get dashboardSubtitle;

  /// No description provided for @architecturePattern.
  ///
  /// In zh, this message translates to:
  /// **'架构模式'**
  String get architecturePattern;

  /// No description provided for @featureFirstDetail.
  ///
  /// In zh, this message translates to:
  /// **'按业务功能垂直切分'**
  String get featureFirstDetail;

  /// No description provided for @sampleTasks.
  ///
  /// In zh, this message translates to:
  /// **'示例任务'**
  String get sampleTasks;

  /// No description provided for @completedTaskCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条已完成'**
  String completedTaskCount(int count);

  /// No description provided for @themeMode.
  ///
  /// In zh, this message translates to:
  /// **'主题模式'**
  String get themeMode;

  /// No description provided for @themeModeCount.
  ///
  /// In zh, this message translates to:
  /// **'3'**
  String get themeModeCount;

  /// No description provided for @themeModeDetail.
  ///
  /// In zh, this message translates to:
  /// **'系统 / 亮色 / 暗色'**
  String get themeModeDetail;

  /// No description provided for @coreDependencies.
  ///
  /// In zh, this message translates to:
  /// **'核心依赖'**
  String get coreDependencies;

  /// No description provided for @clearResponsibilities.
  ///
  /// In zh, this message translates to:
  /// **'均有明确职责边界'**
  String get clearResponsibilities;

  /// No description provided for @getStarted.
  ///
  /// In zh, this message translates to:
  /// **'开始使用'**
  String get getStarted;

  /// No description provided for @tryMvvm.
  ///
  /// In zh, this message translates to:
  /// **'体验 MVVM'**
  String get tryMvvm;

  /// No description provided for @tryMvvmSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'查看异步任务增删改'**
  String get tryMvvmSubtitle;

  /// No description provided for @understandArchitecture.
  ///
  /// In zh, this message translates to:
  /// **'理解架构'**
  String get understandArchitecture;

  /// No description provided for @understandArchitectureSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'查看依赖与目录职责'**
  String get understandArchitectureSubtitle;

  /// No description provided for @switchTheme.
  ///
  /// In zh, this message translates to:
  /// **'切换主题'**
  String get switchTheme;

  /// No description provided for @switchThemeSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'验证主题持久化'**
  String get switchThemeSubtitle;

  /// No description provided for @aiReadyDescription.
  ///
  /// In zh, this message translates to:
  /// **'仓库根目录的 AGENTS.md 是 AI 开发的统一入口。'**
  String get aiReadyDescription;

  /// No description provided for @tasksTitle.
  ///
  /// In zh, this message translates to:
  /// **'任务列表示例'**
  String get tasksTitle;

  /// No description provided for @tasksSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'完整展示 Repository、ViewModel 与异步 View 的协作方式。'**
  String get tasksSubtitle;

  /// No description provided for @refreshTasks.
  ///
  /// In zh, this message translates to:
  /// **'刷新任务'**
  String get refreshTasks;

  /// No description provided for @newTask.
  ///
  /// In zh, this message translates to:
  /// **'新建任务'**
  String get newTask;

  /// No description provided for @taskName.
  ///
  /// In zh, this message translates to:
  /// **'任务名称'**
  String get taskName;

  /// No description provided for @taskNameHint.
  ///
  /// In zh, this message translates to:
  /// **'例如：接入真实 REST API'**
  String get taskNameHint;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In zh, this message translates to:
  /// **'创建'**
  String get create;

  /// No description provided for @emptyTasks.
  ///
  /// In zh, this message translates to:
  /// **'暂无任务，创建一条试试。'**
  String get emptyTasks;

  /// No description provided for @completed.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In zh, this message translates to:
  /// **'待处理'**
  String get pending;

  /// No description provided for @deleteTask.
  ///
  /// In zh, this message translates to:
  /// **'删除任务'**
  String get deleteTask;

  /// No description provided for @retry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retry;

  /// No description provided for @aboutTitle.
  ///
  /// In zh, this message translates to:
  /// **'工程说明'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'依赖保持精简，每个包只解决一个清晰问题。'**
  String get aboutSubtitle;

  /// No description provided for @mvvmDataFlow.
  ///
  /// In zh, this message translates to:
  /// **'MVVM 数据流'**
  String get mvvmDataFlow;

  /// No description provided for @domainInterface.
  ///
  /// In zh, this message translates to:
  /// **'领域接口'**
  String get domainInterface;

  /// No description provided for @stateAndDi.
  ///
  /// In zh, this message translates to:
  /// **'状态管理与依赖注入'**
  String get stateAndDi;

  /// No description provided for @riverpodReason.
  ///
  /// In zh, this message translates to:
  /// **'让 ViewModel 可测试、依赖可替换，并统一同步/异步状态表达。'**
  String get riverpodReason;

  /// No description provided for @declarativeRouting.
  ///
  /// In zh, this message translates to:
  /// **'声明式路由'**
  String get declarativeRouting;

  /// No description provided for @goRouterReason.
  ///
  /// In zh, this message translates to:
  /// **'支持深链、Web URL 与嵌套路由，ShellRoute 统一承载自适应导航。'**
  String get goRouterReason;

  /// No description provided for @httpClient.
  ///
  /// In zh, this message translates to:
  /// **'HTTP 客户端'**
  String get httpClient;

  /// No description provided for @dioReason.
  ///
  /// In zh, this message translates to:
  /// **'提供拦截器、超时、取消请求和灵活适配器，便于建设统一网络层。'**
  String get dioReason;

  /// No description provided for @lightweightSettings.
  ///
  /// In zh, this message translates to:
  /// **'轻量本地配置'**
  String get lightweightSettings;

  /// No description provided for @sharedPreferencesReason.
  ///
  /// In zh, this message translates to:
  /// **'使用 SharedPreferencesAsync 保存主题、语言等非敏感偏好。'**
  String get sharedPreferencesReason;

  /// No description provided for @aiDevelopmentSupport.
  ///
  /// In zh, this message translates to:
  /// **'AI 开发支持'**
  String get aiDevelopmentSupport;

  /// No description provided for @aiDevelopmentDescription.
  ///
  /// In zh, this message translates to:
  /// **'AGENTS.md 提供架构地图、分层约束、命令和完成标准；CLAUDE.md 复用同一规则源。'**
  String get aiDevelopmentDescription;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'偏好设置'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'主题和语言选择会持久化，重启应用后仍然生效。'**
  String get settingsSubtitle;

  /// No description provided for @themeSectionDescription.
  ///
  /// In zh, this message translates to:
  /// **'ColorScheme 负责 Material 角色色，业务状态色由 ThemeExtension 提供。'**
  String get themeSectionDescription;

  /// No description provided for @systemTheme.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In zh, this message translates to:
  /// **'亮色'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In zh, this message translates to:
  /// **'暗色'**
  String get darkTheme;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统，或为应用选择固定显示语言。'**
  String get languageDescription;

  /// No description provided for @systemLanguage.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get systemLanguage;

  /// No description provided for @chinese.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get chinese;

  /// No description provided for @english.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @semanticColors.
  ///
  /// In zh, this message translates to:
  /// **'语义颜色'**
  String get semanticColors;

  /// No description provided for @success.
  ///
  /// In zh, this message translates to:
  /// **'成功'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In zh, this message translates to:
  /// **'警告'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In zh, this message translates to:
  /// **'信息'**
  String get info;

  /// No description provided for @error.
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get error;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
