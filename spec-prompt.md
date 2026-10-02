# Kiro Spec prompt - copy past to Kiro in Spec model

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
