# Kiro Spec prompt（复制粘贴进 Kiro 的 Spec 模式）

<!-- 中文说明：下面这段英文直接粘贴给 Kiro。它会依次生成
     .kiro/specs/ivr-as-code/requirements.md → design.md → tasks.md，
     每一步都会停下来等你 approve —— 这正是 demo 里要展示的招牌流程。
     英文给模型效果更好；steering 文件里已经有项目背景，不用重复写。 -->

Create a spec for converting our manually-maintained Amazon Connect IVR
main-menu contact flow into Terraform-managed infrastructure.

Context (also in .kiro/steering/):
- `flows/main-menu.json` is a sanitized example of our IVR main menu
  (welcome prompt → press 1 billing / 2 self-service / 3 general queue).
- Today every release hand-edits the flow in the Connect console: no version
  control, no review, no rollback.

Requirements:
1. Generate Terraform code under `terraform-live/` (scratch dir, do NOT touch
   `terraform/`) that deploys `flows/main-menu.json` as an
   `aws_connect_contact_flow` resource, with `content` rendered via
   `templatefile()` so queue ARNs are injected as variables.
2. Variables for: connect instance ID, flow name, billing queue ARN, general
   queue ARN, tags. No hardcoded ARNs or IDs anywhere.
3. Outputs for the contact flow ID and ARN.
4. The code must pass `terraform fmt -check` and `terraform validate`.

Acceptance criteria:
- `terraform validate` passes with no AWS credentials.
- `terraform plan` (read-only credentials) shows exactly one resource to create
  and no changes to anything else.
- A teammate can review the whole change as a pull request diff.

Non-goals (do NOT do these):
- No `terraform apply`, no changes to any real AWS environment.
- No CI pipeline, no multi-environment setup — single flow, single module.
