---
inclusion: fileMatch
fileMatchPattern: "flows/**,terraform/**,.kiro/specs/**"
---

# Repo structure

- `flows/*.json` — source of truth for IVR logic. Sanitized examples only.
  ARN/ID placeholders use `${snake_case_name}` template variables.
- `terraform/` — `versions.tf`, `variables.tf`, `main.tf`, `outputs.tf`.
  One `aws_connect_contact_flow` resource per flow file.
- `terraform-live/` — scratch directory where the agent generates code during a
  live demo. Never commit it; diff it against `terraform/` (the reference).
- `.kiro/specs/<feature>/` — Kiro spec artifacts: `requirements.md`,
  `design.md`, `tasks.md`. Review each before approving the next.
