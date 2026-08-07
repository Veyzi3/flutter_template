# Contributing

感谢参与改进 Hale Flutter MVVM Template。

## 开发流程

1. 从 `main` 创建范围明确的分支。
2. 遵循 `AGENTS.md` 与 `docs/architecture.md` 的分层约束。
3. 新依赖应说明现有能力为何不足，避免批量升级。
4. 为业务分支添加测试；架构、目录或命令变化时同步文档。
5. 提交 Pull Request 前运行：

```powershell
dart format .
flutter analyze
flutter test
```

## Pull Request

- 标题简洁描述用户可观察的变化。
- 正文说明动机、实现边界、验证结果和未验证风险。
- 不提交 Token、密钥、真实生产地址、个人数据或生成的构建产物。
- 保持单个 PR 聚焦，不混入无关重构或依赖升级。

提交即表示你同意按项目的 MIT License 授权贡献内容。
