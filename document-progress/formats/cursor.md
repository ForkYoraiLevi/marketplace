---
description: "Plan large tasks upfront with structured-handoff and write progress to disk so nothing is lost"
alwaysApply: true
---

## Document Progress

Large tasks fail silently when context is lost — compaction drops details, sessions time out, and the next agent starts from scratch. Prevent this by planning upfront and writing progress to disk as you go.

### When This Applies

Use this workflow for any task that involves **three or more steps**, **touches more than two files**, or **could take longer than a few minutes**. Skip it for trivial one-shot fixes.

### Plan Before You Start

For non-trivial work, create a structured task plan before writing code:

1. **Generate a handoff structure.** If the `structured-handoff` skill is available, run it:
   ```
   uv run structured-handoff/scripts/generate_handoff.py --task "DESCRIPTION"
   ```
   This creates a `.tasks/` directory with `rules.md`, `scope.md`, `research.md`, and numbered task files.

2. **If the skill is not available**, create the plan manually:
   - Write a `scope.md` with the objective, context, and success criteria
   - List the files involved and why
   - Break the work into numbered steps with clear acceptance criteria

3. **Fill in the plan before coding.** Read the codebase, identify the files, populate the task descriptions. A plan you write after understanding the code is worth ten plans you write before reading it.

### Write Progress to Disk

Do NOT rely on conversation context to remember what you've done. Context compacts, sessions end, and models forget. Write durable state to files instead.

- **Update task files as you complete them.** Mark tasks done, note what changed, record any surprises or deviations from the plan.
- **After completing each task**, write a brief summary to a progress log (e.g., `PROGRESS.md` or inline in the task file) that includes:
  - What was done
  - What files were changed
  - Any decisions made and why
  - What comes next
- **Commit after each logical step.** Git history is the most durable progress log. Each commit message should be self-explanatory.

### Why This Matters

- **Resumability.** If the session ends or context resets, the next agent (or you after compaction) can read `.tasks/` and pick up exactly where things left off.
- **Accountability.** Written plans catch scope creep early. If what you're doing doesn't match a task file, you've drifted.
- **Visibility.** The user can check `.tasks/` at any time to see what's been done and what remains without asking.

### What NOT to Do

- Do NOT start multi-step work without a written plan — even a rough one.
- Do NOT keep progress only in conversation context. Context is ephemeral; files are permanent.
- Do NOT skip updating the plan when the work deviates from it. An outdated plan is worse than no plan.
- Do NOT leave task files in a stale state. If a task is done, mark it done immediately.
