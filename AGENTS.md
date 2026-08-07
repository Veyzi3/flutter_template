# AGENTS.md

本文件是本仓库中 AI 编程工具的统一规则源。开始修改前先阅读本文件与 `docs/architecture.md`。

## 项目目标

- Flutter 3.44+ / Dart 3.12+ 的工程化 MVVM 模板。
- 依赖精简、边界清晰、功能可独立测试。
- 默认支持 Android、iOS、Web 与桌面平台，不写平台专属实现，除非需求明确。

## 快速命令

```powershell
flutter pub get
dart format .
flutter analyze
flutter test
flutter run
flutter run --dart-define=API_BASE_URL=https://example.com
```

Windows 上若 `flutter` 包装脚本被锁，先检查是否有其他 Flutter/Dart 任务占用 SDK，不要直接结束不属于当前任务的进程。

## 架构地图

```text
lib/
  app/                  # App 根组件与 go_router 配置
  core/                 # 跨功能基础设施：主题、网络、错误、通用组件
  features/<feature>/
    data/               # Repository 实现、DTO、数据源
    domain/             # 实体、Repository 接口、纯业务规则
    presentation/       # Page、Widget、Riverpod ViewModel
```

依赖方向只能是 `presentation -> domain <- data`。`core` 不得依赖具体 feature。页面不直接调用 Dio、本地存储或数据源。

## MVVM 约定

- View 使用 `ConsumerWidget`/`ConsumerStatefulWidget`，只渲染状态和发送用户意图。
- ViewModel 使用 Riverpod `Notifier` 或 `AsyncNotifier`，命名为 `*ViewModel`。
- 异步页面状态优先使用 `AsyncValue<T>`，必须处理 loading、error、data。
- Repository 接口放 `domain/`，实现放 `data/`，通过 Provider 注入。
- domain 层不导入 Flutter UI、Dio、shared_preferences。
- 禁止把 BuildContext、Widget 或 ThemeData 存进 ViewModel/Repository。

## 主题约定

- Material 标准角色色使用 `Theme.of(context).colorScheme`。
- success、warning、info 等业务色使用 `AppSemanticColors`。
- 间距使用 `context.spacing`；常规卡片圆角不超过 8。
- 不在页面硬编码品牌色。新增语义色时同时补充亮色、暗色和 `lerp/copyWith`。
- 仅持久化 `ThemeMode` 等可序列化选择，不持久化 `ThemeData`。

## 网络与配置

- HTTP 请求经 `dioProvider` 或 feature 自己的数据源发起。
- API 地址通过 `--dart-define=API_BASE_URL=...` 注入。
- Token、密钥、生产地址不得提交到源码、测试快照或文档。
- 将 Dio 错误转换为领域可理解的失败后再暴露给 ViewModel。

## 修改流程

1. 先定位对应 feature，并读完同层相邻文件。
2. 优先扩展现有模式；新增依赖前说明现有能力为何不足。
3. 跨层变更按 domain -> data -> presentation 顺序完成。
4. 为 ViewModel、Repository 业务分支添加单元测试；关键导航和交互添加 widget test。
5. 运行与改动风险匹配的检查，并如实报告未执行项。

## 完成标准

- `dart format .` 无新增格式变化。
- `flutter analyze` 无错误和警告。
- `flutter test` 通过，或明确说明无法执行的环境原因。
- 新功能遵守分层依赖，不泄露密钥，不在 View 中直接访问数据层。
- 依赖、公共命令或目录职责变化时同步更新 README 与 `docs/architecture.md`。

## AI 修改护栏

- 不删除或覆盖用户已有改动；不执行 `git reset --hard`、`git clean -fd` 等破坏性命令。
- 不伪造生成文件、构建结果、设备验证或网络响应。
- 不为了抽象而抽象；只有出现真实复用或复杂度时才提取公共层。
- 不批量升级依赖。先执行 `flutter pub outdated`，逐项升级并验证迁移说明。
- 需求不涉及 App 内 AI 时，不添加模型 SDK、API Key 或聊天功能。
