# Flutter MVVM 工程架构

## 设计目标

模板采用按业务功能垂直切分的 MVVM。每个 feature 自己拥有 data、domain、presentation，减少全局目录随着业务增长而失控的问题。

```text
View -> ViewModel -> Repository interface <- Repository implementation -> Data source
               Riverpod Provider 负责创建与替换依赖
```

## 启动链路

1. `lib/main.dart` 初始化 Flutter 并创建 `ProviderScope`。
2. `lib/app/app.dart` 组装主题、本地化和路由。
3. `lib/app/router.dart` 通过 `ShellRoute` 提供移动端 NavigationBar 与宽屏 NavigationRail。
4. `ThemeController` 异步读取主题偏好，读取完成前使用系统主题。
5. `LocaleController` 读取语言偏好；空值表示跟随操作系统。

## 环境与配置

- `AppConfig` 是编译期环境参数的唯一读取入口，业务代码不得散落 `String.fromEnvironment`。
- `APP_FLAVOR` 只接受 `development`、`staging`、`production`。
- `API_BASE_URL` 必须是绝对 URL，生产环境禁止继续使用模板占位地址。
- `ENABLE_NETWORK_LOGS` 默认关闭；日志不得记录 Token、Cookie、请求体或个人信息。
- 密钥不属于 `--dart-define` 的安全使用场景。客户端无法保守秘密，敏感能力应由服务端代理。

## 分层职责

### presentation

- Page/Widget 负责布局、输入和交互反馈。
- ViewModel 负责用例编排、状态转换和错误状态。
- 不直接依赖 Dio、SharedPreferences 或具体 Repository 实现。

### domain

- 业务实体、值对象、Repository 抽象和纯业务规则。
- 保持与 Flutter UI 和数据源技术无关。

### data

- 实现 domain 的 Repository 接口。
- 负责 DTO 映射、远程/本地数据源与缓存策略。
- 当前任务示例使用 `InMemoryTaskRepository`，替换为真实接口时无需修改 View。

### core

- 只放两个及以上 feature 真正共享的能力。
- `theme/`：Material 3 主题、业务语义色与间距令牌。
- `config/`：环境参数读取、类型转换和启动校验。
- `logging/`：日志抽象；业务代码不直接绑定第三方上报 SDK。
- `localization/`：语言选择状态及其持久化，不包含具体业务文案。
- `network/`：Dio 配置、超时和基础日志拦截器。
- `errors/`：跨层可识别的异常基类。
- `widgets/`：不含具体业务语义的通用组件。

## 状态管理

- Riverpod Provider 负责依赖注入。
- `Notifier<T>` 处理同步状态，`AsyncNotifier<T>` 处理需要加载/刷新/失败的状态。
- View 用 `ref.watch` 订阅状态，用 `ref.read(provider.notifier)` 发送命令。
- 测试通过 Provider override 注入内存仓库，不需要全局 service locator。

Provider 的生命周期应尽可能贴近使用方。全局 Provider 仅用于配置、路由、主题、网络客户端等应用级依赖；feature 私有 Provider 留在 feature 内。

## 错误与日志

1. data source 捕获 Dio、存储或解析异常。
2. data 层将技术异常转换为 `AppException` 或 feature 领域失败。
3. ViewModel 将失败保存在 `AsyncValue.error` 或明确的页面状态中。
4. View 根据领域语义展示反馈，不解析 HTTP 状态码和 DioException。

`mapDioException` 提供通用网络错误基线。接口返回的业务错误码应在对应 feature 的 data 层转换，避免 core 依赖具体业务。日志通过 `AppLogger` 注入，后续接入 Sentry 等服务时无需污染业务代码。

## 主题系统

- `AppTheme` 是 ThemeData 的唯一构建入口。
- `ColorScheme` 负责 primary、secondary、surface、error 等 Material 角色。
- `AppSemanticColors` 负责 success、warning、info、border 等业务语义。
- `AppSpacing` 统一页面和组件间距。
- `ThemeController` 只保存 ThemeMode 字符串，避免持久化不可迁移的 ThemeData。

## 多语言

- 使用 Flutter 官方 `gen_l10n`，翻译源位于 `lib/l10n/*.arb`。
- `app_zh.arb` 是模板文件；新增 key 时必须同步补齐 `app_en.arb`。
- View 通过 `context.l10n` 获取文案，不在 Widget 中硬编码用户可见字符串。
- `LocaleController` 只持久化语言代码；`null` 表示跟随系统。
- Repository 返回的用户数据不随界面语言切换。服务端错误应转换为稳定错误码，再由 presentation 映射为本地化文案；domain/data 不依赖 `AppLocalizations`。
- 修改 ARB 后运行 `flutter gen-l10n`，生成文件位于 `lib/l10n/generated/`。

## 新增 feature

1. 创建 `lib/features/<name>/{data,domain,presentation}`。
2. 先定义 domain 实体和 Repository 接口。
3. 在 data 实现接口，并通过 Provider 注入。
4. 用 Notifier/AsyncNotifier 创建 ViewModel。
5. 创建 View 并在 `lib/app/router.dart` 注册路由。
6. 添加 ViewModel/Repository 测试，运行格式化、分析和测试。

## 测试策略

| 层级 | 测试重点 |
| --- | --- |
| domain | 值对象、校验、纯业务规则和边界条件 |
| data | DTO 映射、错误转换、缓存与 Repository 分支 |
| ViewModel | loading/error/data 状态和用户命令，使用 Provider override |
| Widget | 关键渲染、输入、导航和错误反馈 |
| 集成测试 | 登录、支付等跨页面主链路，按项目需要引入 |

测试目录镜像 `lib`。内存实现允许注入时间、初始数据和延迟，避免测试依赖真实时钟或等待。CI 默认运行格式检查、分析和覆盖率测试；覆盖率是发现盲区的信号，不以单一百分比代替有效断言。

## 工程化基线

- `analysis_options.yaml` 在官方 lint 上增加异步、资源释放、类型和格式约束。
- `.github/workflows/quality.yml` 是合并前质量门禁。
- `.github/dependabot.yml` 小批量维护 Dart 和 Actions 依赖。
- `.vscode/` 提供推荐插件、格式化、环境调试和质量任务。
- 公共依赖升级前先运行 `flutter pub outdated`，逐项核对迁移说明，不批量跨大版本升级。

## 依赖说明

| 依赖 | 用途 | 选型边界 |
| --- | --- | --- |
| flutter_riverpod | 状态管理、依赖注入、异步状态 | 不把 Provider 当全局可变变量使用 |
| go_router | 声明式路由、深链、ShellRoute | 页面不手工维护导航索引 |
| dio | HTTP、拦截器、超时、取消 | DTO/错误转换留在 data 层 |
| shared_preferences | 非敏感轻量设置 | Token 等敏感信息改用安全存储 |

没有引入 Freezed、代码生成器、数据库或日志框架，因为当前模板没有足够复杂度证明它们必要。业务增长后再按实际需求加入，避免模板一开始就背负生成链和维护成本。
