# Kiro Demo 讲稿：IVR 手工维护 → Terraform 即代码

观众：团队里没用过 Kiro 的同事。时长：8～10 分钟。全程只读演示，不碰生产。

## 准备清单（demo 前一天）

- [ ] 安装 Kiro 并登录（GitHub / Google / AWS Builder ID 均可）
- [ ] 用 Kiro 打开本目录 `kiro-ivr-demo/`
- [ ] 确认本月还有 50 credits（免费版每月重置；spec 全流程约耗 5～10 credits）
- [ ] 模型选 **Auto**（省 credit）；spec 生成那一步可切 Sonnet 4.5
- [ ] 本机装好 `terraform`（`terraform validate` 不需要 AWS 凭证，可离线演示）
- [ ] 彩排一遍再正式演示

## 讲稿时间轴

**1. 痛点（1 分钟）**
"我们每次 release 都要有人手工进 Connect console 改 IVR：没版本、没 review、改错了没法回滚。今天演示怎么让这件事变成一次 PR。"

**2. Steering：团队规范一次写好，次次生效（1 分钟）**
打开 `.kiro/steering/` 给观众看三个文件：`product.md`（项目背景：call center、IVR 即 contact flow）、
`tech.md`（Terraform 规范：变量化、不硬编码 ARN、fmt+validate 必须过）、`structure.md`（目录约定）。
"这相当于团队的 AGENTS.md，Kiro 每次干活都会自动读，不用每次在 prompt 里重复。"

**3. Spec 模式：需求 → 设计 → 任务，步步确认（3 分钟）** ⭐ 核心看点
把 `spec-prompt.md` 的英文粘贴进 Kiro Spec 模式。Kiro 会依次生成：
`.kiro/specs/ivr-as-code/requirements.md` → `design.md` → `tasks.md`，
**每一步都停下来等你 approve**。重点讲："这不是 vibe coding 一把梭，
每一步都有文档、有确认，出问题能追溯——这正是我们这种合规项目需要的。"

**4. 执行 tasks，生成 Terraform（2～3 分钟）**
Approve tasks 后让 agent 执行，代码生成到 `terraform-live/`。
跑 `terraform fmt -check && terraform validate`（不需要 AWS 凭证）。
然后 `diff -r terraform terraform-live` 对比参考实现："AI 生成的和参考实现基本一致，
说明 steering 的约束真的生效了。"

**5. Hook：保存自动检查（30 秒，可选）**
现场建一个 agent hook：保存 `.tf` 文件时自动跑 `terraform fmt`。
"以后谁改 Terraform，保存瞬间就被格式化+检查，不用靠自觉。"

**6. 收尾（30 秒）**
"`git diff` 里看到的就是这次 release 的全部变更：flow JSON 改了哪句话、
转接到哪个队列，一目了然。以后 IVR 变更 = 提 PR = 有 review 有回滚。"

## 翻车预案

- **Credit 烧完 / 现场生成翻车**：直接展示 `terraform/` 下的参考实现，
  照着第 4～6 步讲，观众看不出区别。
- **没 AWS 凭证**：只演示到 `terraform validate` 为止，明确说 plan 需要只读凭证、
  今天不做 apply。
- **Kiro spec 生成太慢**：提前跑一遍，把 `.kiro/specs/` 留着，现场直接展示 approve 流程。

## 合规提醒（必说）

- `flows/main-menu.json` 是脱敏示例，**不要把真实客户的 flow JSON 贴进 Kiro**。
- Kiro 免费版默认可能用输入内容改进服务（设置里可关），演示全程只用示例数据。

## 公开参考

- [flow-as-code/flow-as-code](https://github.com/flow-as-code/flow-as-code) —
  开源项目，专门把 Connect contact flow 转成 Terraform（`templatefile` + 变量注入，
  和本 demo 同一路数），说明"IVR 即代码"是走得通的。
- [terraform-aws-connect-callcenter](https://github.com/khamwey/terraform-aws-connect-callcenter) —
  用 Terraform 部署完整 Connect 呼叫中心的例子。
