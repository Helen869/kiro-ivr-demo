# Kiro Demo — English Delivery Script (8–10 min)

Read-only demo. No `terraform apply`, no production changes.

---

## 1. The pain (1 min)

"Hi everyone. Today I want to show you Kiro, AWS's agentic IDE.

Here is our pain: every release, someone hand-edits our IVR in the Connect
console. No version control. No code review. If something breaks, there is
no rollback.

Today I will show you how that manual work becomes a pull request."

## 2. Steering files — conventions written once (1.5 min)

"First, look at `.kiro/steering/`. Three small files: product background,
tech rules, and repo layout.

Why do we need this? Every time you start a new AI chat, the AI knows
nothing about your project. You end up repeating yourself in every prompt:
'Use this pattern, not that one.' Steering fixes that. Think of it as the
team's shared rulebook. Kiro reads it automatically every time it works.
We write our conventions once, and the agent follows them every time.

How are these files made? Two ways. Kiro can analyze your codebase and
auto-generate them. Or you write them by hand. Ours are hand-written,
because business context — like our compliance rules — cannot be inferred
from code. In practice, teams start with auto-generated docs and refine
them by hand."

## 3. Spec mode — the core feature (3 min)

"Now the core feature: spec-driven development.

I paste one prompt into Kiro's Spec mode. It generates `requirements.md`,
then `design.md`, then `tasks.md` — and it stops at each step, waiting for
my approval.

This is not one-shot vibe coding. Every step is documented and confirmed
before moving on. For a compliance-heavy project like ours, that
traceability matters."

## 4. Execute tasks and validate (2–3 min)

"I approve the tasks, and the agent generates Terraform code into
`terraform-live/`.

Then I run `terraform fmt` and `terraform validate`. Note: validate needs
no AWS credentials, so this is safe to run live.

Now I diff it against `terraform-reference/`, our reference implementation. The
AI-generated code matches. The steering constraints actually worked."

## 5. Agent hook — automation on save (30 sec, optional)

"One more small thing: an agent hook. Every time I save a `.tf` file, Kiro
automatically runs `terraform fmt`. No more relying on discipline."

## 6. Closing (30 sec)

"Look at `git diff`: that is the entire release. Which prompt changed,
which queue the callers go to — everything is visible.

IVR changes become pull requests: reviewed, versioned, and easy to roll
back. Thank you."

---

## Backup plans (do NOT say these out loud)

- If credits run out or live generation fails: present the reference
  implementation under `terraform-reference/` and continue from step 4. The audience
  cannot tell the difference.
- If there are no AWS credentials: stop after `terraform validate` and say
  plan needs read-only credentials, which we skip today.
- If spec generation is slow: pre-run it once before the demo and reuse the
  generated `.kiro/specs/` directory.

## Compliance note (say this if asked about data)

"The flow JSON here is a sanitized example. We never put real customer
data or real ARNs into the demo."
