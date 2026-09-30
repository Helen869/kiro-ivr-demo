---
inclusion: always
---

# Tech stack and conventions

- Terraform >= 1.5, AWS provider ~> 5.0. No hardcoded ARNs, account IDs, or
  Connect instance IDs — everything environment-specific is a variable.
- Contact flows are deployed with the `aws_connect_contact_flow` resource.
  `content` is rendered with `templatefile()` from the JSON under `flows/`;
  template variables look like `${billing_queue_arn}`.
- Flow JSON follows the Amazon Connect format, `Version: "2019-10-30"`.
- Every change must pass `terraform fmt -check` and `terraform validate`.
  `terraform validate` needs no AWS credentials; `terraform plan` needs
  read-only credentials and is never run against production in a demo.
- Outputs: expose the contact flow ID and ARN.
- Tag everything with at least `ManagedBy = "terraform"`.
