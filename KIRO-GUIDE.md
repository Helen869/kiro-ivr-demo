# Kiro Team Guide: What It Is, What It Does, How We Use It

*For junior engineers. Read Part 1–3 once, then follow Part 4 hands-on.*

---

## 1. What is Kiro?

- **An agentic IDE by AWS**, built on Code OSS (a VS Code fork) — the UI
  will feel familiar.
- **"Agentic" means:** the AI doesn't just answer questions. It reads
  your files, runs terminal commands, edits code, and executes
  multi-step workflows on its own.
- **Free tier:** 50 credits/month. Enough to learn and run demos like
  this one. Paid tiers exist for heavy daily use.
- You do **not** need an AWS account to use Kiro.

> [SCREENSHOT: Kiro IDE sidebar showing SPECS / AGENT HOOKS /
> AGENT STEERING & SKILLS]

---

## 2. What can Kiro do? (the five things that matter for us)

1. **Vibe mode (chat)** — quick questions and small edits, like any AI
   assistant. Good for exploration.
2. **Spec mode** — *the core differentiator.* Structured development:
   `requirements.md` → `design.md` → `tasks.md`, with **your approval
   at every step**. Then it executes the tasks.
3. **Steering files** — persistent project knowledge. Write your team's
   conventions once; the agent follows them in every session, so you
   never repeat them in prompts.
4. **Agent hooks** — event-driven automation. Example: run
   `terraform fmt` automatically every time a `.tf` file is saved.
5. **Model choice** — pick the right model per task and control cost
   (see 3.3).

---

## 3. How to use Kiro

### 3.1 The `.md` files: steering

**What:** Markdown rulebooks that give Kiro permanent context about
your project.

**Where:**
- `.kiro/steering/` in the project root — workspace scope, applies to
  this project only (this is what we use; it's committed to git so the
  whole team shares it)
- `~/.kiro/steering/` — global scope, applies to all your projects

**The three foundation files** (Kiro can auto-generate these):

| File | Contents |
|---|---|
| `product.md` | What the product is, who uses it, business context — the *why* |
| `tech.md` | Stack, libraries, technical constraints — the *how* |
| `structure.md` | Folder layout, naming conventions, architecture |

**Inclusion modes** (frontmatter at the top of each file controls
when Kiro reads it):

| Mode | Meaning |
|---|---|
| `always` | Loaded in every session. Use for core standards. |
| `fileMatch` | Loaded only when working with matching files (saves context). Example: `fileMatchPattern: "terraform-live/**"`. |
| `manual` | Only when you explicitly reference it in chat. |

**How to create them:** Kiro panel → Steering section → **Generate
Steering Docs** (Kiro analyzes your codebase and drafts the three
files), **or** write them by hand. Rule of thumb: anything the code
can't show — business context, compliance rules — must be hand-written.
In practice: auto-generate first, then refine by hand.

> [SCREENSHOT: `.kiro/steering/` folder + one file's frontmatter]

### 3.2 Spec mode selection

**Where:** chat input bar → mode dropdown → **Spec**. Or: Kiro panel →
SPECS → **+ Create New Spec**.

**Which workflow to pick:**

| Workflow | When to use |
|---|---|
| Requirements-First | Normal features (what we use in this demo) |
| Design-First | You already know the design, want to skip ahead |
| Quick Spec | Small tasks, one pass, no approval gates |
| Bugfix | Diagnosing and fixing bugs |

**The flow:**
1. You describe the feature (paste a prompt)
2. Kiro writes `requirements.md` → **stops, waits for your approval**
3. Kiro writes `design.md` → **stops, waits for your approval**
4. Kiro writes `tasks.md` → **stops, waits for your approval**
5. Kiro executes the tasks

Each approval shows a **Review changes** prompt — click `View changes`
to see the diff, then `Accept all`. This approval-at-every-step is the
whole point: documented, traceable, reviewable — not one-shot code
generation.

**Two small things you'll see:**
- `.config.kiro` — a tiny JSON sidecar per spec (spec ID, type,
  workflow). Kiro's internal bookkeeping; you don't need to read it.
- **Included Steering** (expandable in chat) — proof your steering
  files were loaded into context. Expand it during demos.

> [SCREENSHOT: Spec mode selected in the chat bar]
> [SCREENSHOT: "Review changes (2 pending)" approval prompt]
> [SCREENSHOT: "Included Steering" expanded]

### 3.3 Model selection

**Where:** model picker, bottom-left of the chat input bar.

**Free-tier options:**

| Model | Credit multiplier | Best for |
|---|---|---|
| Claude Sonnet 4.5 | 1.3x | Spec documents, anything the team will review — best quality |
| Claude Haiku 4.5 | 0.4x | Cheap and fast, simple tasks |
| DeepSeek v3.2 / MiniMax / GLM / Qwen | 0.15x–0.5x | Cheapest; avoid "experimental preview" ones for important work |

**Rules:**
- Spec documents and demo work → **Claude Sonnet 4.5**. Quality
  matters most here.
- Do **not** use Claude Sonnet 4 — it's marked [EOL] (retires
  2026-10-14).
- A full spec run costs roughly 10–15 credits; keep an eye on the
  `Kiro Free x / 50` counter in the status bar.

> [SCREENSHOT: model picker with Claude Sonnet 4.5 selected]

### 3.4 Running tasks

After `tasks.md` is approved:
1. Kiro sidebar → **SPECS** → your spec → **Tasks**
2. In the editor, above each task item: **⚡ Start task**

> ⚠️ **It looks like plain text but it IS a button — click it.**
> Click the first one and Kiro starts executing. (This trips up
> everyone the first time.)

Or skip the UI: type in chat `Run all tasks for <spec-name>`.
Tasks marked with `*` are optional verification tasks — skip them to
save credits.

> [SCREENSHOT: tasks.md with the ⚡ Start task buttons — circle them]

---

## 4. Demo walkthrough: IVR contact flow → Terraform

**Context:** Our IVR menus are Amazon Connect contact flows, currently
hand-edited in the console every release — no version control, no
review, no rollback. Goal: flows as code.

**Repo:** https://github.com/Helen869/kiro-ivr-demo

| Path | What it is |
|---|---|
| `flows/main-menu.json` | Sanitized example IVR (welcome → press 1/2/3). Source of truth. |
| `.kiro/steering/` | The team rulebook (3 files). |
| `terraform-reference/` | Hand-written reference implementation — the "answer key". |
| `spec-prompt.md` | The prompt to paste into Spec mode. |
| `terraform-live/` | **Does not exist yet.** Kiro creates it during the demo. Never commit it. |

### Step 1 — Open the project, trust the workspace
Clone the repo, open the folder in Kiro. If the bottom bar shows
**Restricted Mode**, trust the workspace — otherwise the agent cannot
run terminal commands.

→ **Expect:** the repo in the file explorer; no Restricted Mode banner.

> [SCREENSHOT: Kiro with the repo open]

### Step 2 — Look at the steering files
Open `.kiro/steering/`. Show the three files; open one and point at
the frontmatter (`inclusion: always`).

→ **Expect:** the audience gets "conventions written once, followed
every session".

> [SCREENSHOT: steering folder + frontmatter]

### Step 3 — Select model + Spec mode
Model = **Claude Sonnet 4.5**, chat mode = **Spec**.

→ **Expect:** both selections visible in the chat bar.

> [SCREENSHOT: chat bar showing model + Spec mode]

### Step 4 — Paste the spec prompt, approve requirements
Copy the English prompt from `spec-prompt.md`, paste, send. Kiro reads
the flow JSON, the reference files, and steering, then writes
`requirements.md` — **and stops**.

→ **Expect:** a "Review changes" prompt (requirements.md +
.config.kiro). Click `View changes`, then `Accept all`.

> [SCREENSHOT: Review changes prompt]

### Step 5 — Approve the design
Click **Generate Tech Design** → review → accept. (Kiro sometimes
auto-fixes the document format to pass its own validation — that's
normal; it checks its own output.)

→ **Expect:** `design.md` appears under `.kiro/specs/`.

> [SCREENSHOT: design.md in the specs folder]

### Step 6 — Approve the tasks
Click **Generate Task List** → review → accept.

→ **Expect:** `tasks.md` with checkbox items, each traced back to
requirements (you'll see `_Requirements: 1.2, 3.1_` style references).

> [SCREENSHOT: tasks.md task list]

### Step 7 — Run the tasks
SPECS panel → spec → Tasks → click the first **⚡ Start task**.

→ **Expect:** Kiro creates `terraform-live/` and writes the `.tf`
files; checkboxes flip from `- [ ]` to `- [x]` as tasks complete.

> [SCREENSHOT: terraform-live/ created with .tf files]

### Step 8 — Validate
```cmd
cd terraform-live
terraform fmt -check
terraform validate
```

→ **Expect:** both pass. No AWS credentials needed — `validate` is a
local syntax check.

> [SCREENSHOT: terminal showing validate success]

### Step 9 — Diff against the reference
```cmd
diff -r ..\terraform-reference .\terraform-live
```

→ **Expect:** nearly identical. Talking point: *"The AI-generated
code matches the reference — the steering constraints worked. No
hardcoded ARNs, everything parameterized."*

> [SCREENSHOT: diff output]

### Step 10 — Close
Show `git status`: the entire "release" is visible as code changes.
Closing line: *"IVR changes become pull requests — reviewed,
versioned, rollback-ready."*

---

## 5. How WE use Kiro (team norms)

- **Spec mode** for anything the team will review (infra changes,
  shared modules). **Vibe mode** for solo exploration.
- **Steering files are code:** changes get reviewed like any PR.
- **Never** paste customer data, real ARNs, or production flow JSON
  into Kiro. (Free-tier inputs may be used for service improvement —
  check the data-sharing setting.)
- Demos are **read-only**: we never run `terraform apply` from a demo.
- **Credit hygiene:** one full rehearsal to prove the flow works (~25
  credits). For the real demo, **reuse the rehearsed `.kiro/specs/`**
  (don't regenerate — saves ~11 credits and ~20 minutes of waiting),
  **delete `terraform-live/`** so the audience sees code generated
  live, then run tasks → validate → diff (~15–20 credits).

---

## 6. Troubleshooting

| Symptom | Fix |
|---|---|
| `scoop`/`choco` not recognized on Windows | Use `winget install HashiCorp.Terraform` (built into Windows) |
| Restricted Mode in the status bar | Trust the workspace, or the agent can't run terminal commands |
| Can't find any "Run" button | The **⚡ Start task** labels in the editor *are* the buttons |
| Spec generation is slow (design took ~18 min once) | Normal — reuse a rehearsed spec for live demos |
| `aws-mcp Connection Failed` in the sidebar | Irrelevant to this demo — ignore it |
| A push/operation timed out but may have succeeded | Verify with a read before retrying — don't blindly re-run |

## 7. FAQ

**How are steering files made?**
Kiro panel → Steering section → Generate Steering Docs (auto from
codebase), or hand-written. Hand-write anything the code can't show
(business context, compliance). Practical flow: auto-generate, then
refine by hand.

**Does Kiro read steering files by default?**
Yes — controlled by each file's `inclusion` frontmatter: `always`
(every session), `fileMatch` (only for matching files), `manual`
(only when referenced).

**What is `.config.kiro`?**
Per-spec metadata sidecar (ID, type, workflow). Kiro writes it;
you ignore it.

**Is the free tier enough?**
For learning and demos, yes — one full run is ~25 credits. Heavy
daily use burns 50 credits in a day or two.

**Why not just use chat/vibe mode for everything?**
You can — for throwaway work. Spec mode earns its keep when the
output needs review, traceability, or compliance: every decision is
documented before code exists.
