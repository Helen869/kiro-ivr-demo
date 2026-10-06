---
inclusion: always
---

# Product context

We run a health-insurance call center on AWS (Amazon Connect). Our IVR menus are
Amazon Connect contact flows.

Current pain: every release, someone hand-edits the contact flow in the Connect
console. No version control, no code review, no rollback, and console edits drift
from what the team thinks is deployed.

Goal of this repo: contact flows as code. The flow JSON under `flows/` is the
source of truth for IVR logic; Terraform under `terraform-reference/` deploys it via the
`aws_connect_contact_flow` resource. Releases become pull requests, not console
clicks.

Compliance: never put real customer data, real ARNs, or production flow JSON in
this repo. Examples must be sanitized.
