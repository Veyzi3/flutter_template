# Hale Flutter MVVM Template

一个面向真实项目的 Flutter 工程化模板。基于 feature-first MVVM 组织代码，内置状态管理、依赖注入、声明式路由、主题、网络、环境配置、测试和 GitHub CI，可作为新项目的起点，而不是只展示计数器的 Demo。

要求 Flutter 3.44+、Dart 3.12+，默认支持 Android、iOS、Web、Windows、macOS 和 Linux。

## 核心能力

- **清晰分层**：`presentation -> domain <- data`，功能按业务垂直切分
- **状态与依赖注入**：Riverpod `Notifier` / `AsyncNotifier` 与 Provider override
- **声明式导航**：go_router、ShellRoute、移动端 NavigationBar 和宽屏 NavigationRail
- **主题系统**：Material 3、亮/暗主题、语义色、统一间距与主题偏好持久化
- **网络基础设施**：Dio、超时、可控请求日志和面向领域的错误转换
- **类型化配置**：通过 `--dart-define` 区分开发、预发布和生产环境
- **质量保障**：强化 lint、单元测试、Widget 测试、覆盖率和 GitHub Actions
- **协作配置**：Dependabot、VS Code 推荐插件/调试任务、AI 编程规则

## 快速开始

```powershell
flutter pub get
flutter run
```

带开发环境参数运行：

```powershell
flutter run `
  --dart-define=APP_FLAVOR=development `
  --dart-define=API_BASE_URL=https://api.example.com `
  --dart-define=ENABLE_NETWORK_LOGS=true
```

生产构建必须提供真实 API 地址，否则占位地址校验会阻止应用启动：

```powershell
flutter build apk `
  --release `
  --dart-define=APP_FLAVOR=production `
  --dart-define=API_BASE_URL=https://api.your-domain.com
```

| 参数 | 默认值 | 说明 |
| --- | --- | --- |
| `APP_FLAVOR` | `development` | `development`、`staging` 或 `production` |
| `API_BASE_URL` | `https://api.example.com` | 必须是绝对 URL；不要在源码中提交密钥 |
| `ENABLE_NETWORK_LOGS` | `false` | 是否输出基础请求日志，不记录请求体和 Token |

## 目录结构

```text
lib/
  app/                         # App 根组件和 go_router 配置
  core/
    config/                    # 编译期环境配置与校验
    errors/                    # 跨层异常类型
    logging/                   # 可替换日志边界
    network/                   # Dio、拦截器和错误映射
    theme/                     # ThemeData、语义色和间距
    widgets/                   # 无业务语义的公共组件
  features/<feature>/
    data/                      # Repository 实现、DTO、数据源
    domain/                    # 实体、Repository 接口、业务规则
    presentation/              # Page、Widget、Riverpod ViewModel
test/                          # 与 lib 结构对应的测试
docs/architecture.md           # 架构原则和扩展指南
```

页面只负责渲染状态和发送用户意图。ViewModel 编排业务，Repository 接口归 domain 所有，data 提供实现。完整约束见 [docs/architecture.md](docs/architecture.md)。

## 常用依赖

| 依赖 | 用途 | 为什么保留 |
| --- | --- | --- |
| `flutter_riverpod` | 状态管理与依赖注入 | 易测试、无需全局 service locator |
| `go_router` | 路由、深链、ShellRoute | Flutter 官方维护的声明式路由方案 |
| `dio` | HTTP、拦截器、取消与超时 | data 层可统一 DTO 和错误转换 |
| `shared_preferences` | 非敏感轻量设置 | 当前用于 ThemeMode 持久化 |
| `flutter_localizations` | Flutter 内置组件本地化 | 为多语言扩展保留标准入口 |

模板刻意不预装 Freezed、build_runner、数据库、安全存储、日志上报或代码生成。需要对应业务时再引入，并同时补充抽象、迁移说明和测试，避免默认生成链拖慢所有项目。

## 开发与质量检查

```powershell
dart format .
flutter analyze
flutter test
flutter test --coverage
```

GitHub Actions 会在 push 到 `main` 和 Pull Request 时执行依赖安装、格式检查、静态分析和带覆盖率的测试。Dependabot 每周检查 Dart 依赖、每月检查 Actions 版本。

VS Code 打开仓库后会推荐 Dart 与 Flutter 扩展，并提供 development/production 调试配置和 `Flutter: quality` 任务。Android Studio 或 IntelliJ 安装官方 **Flutter** 插件即可，Dart 插件会作为依赖安装。

## 新增功能

1. 创建 `lib/features/<name>/{domain,data,presentation}`。
2. 先在 domain 定义实体、业务规则和 Repository 接口。
3. 在 data 实现接口并完成 DTO/异常转换。
4. 在 presentation 创建 ViewModel 和页面，通过 Provider 注入 Repository。
5. 在 `lib/app/router.dart` 注册路由。
6. 按 `lib` 的路径在 `test` 中添加业务分支和关键交互测试。

可以参考 `features/tasks` 的最小闭环。不要让 View 直接访问 Dio、本地存储或具体 Repository。

## Android 构建说明

当 Windows 的 Pub 缓存和工程位于不同盘符时，Kotlin 增量缓存可能报 `different roots` 或 `Storage ... is already registered`。本模板的 `android/gradle.properties` 已针对这一场景关闭 Kotlin 增量编译并使用进程内编译。遇到缓存问题先执行：

```powershell
cd android
.\gradlew.bat --stop
cd ..
flutter clean
flutter pub get
```

不要直接结束不属于当前项目的 Flutter/Dart 进程。

## 贡献

提交前请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 和 [AGENTS.md](AGENTS.md)，确保格式化、静态分析和测试通过。架构或公共命令发生变化时，请同步更新本文和架构文档。

## License

基于 [MIT License](LICENSE) 开源。
