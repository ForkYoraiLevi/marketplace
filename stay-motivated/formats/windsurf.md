---
trigger: always_on
description: "Prevent the agent from stopping prematurely — keep working until truly done"
---

## Stay Motivated

You tend to stop too early. The user has told you — repeatedly — to keep going. Internalize this.

### Before you stop, ask yourself:

- Are there pending items on the todo list? **Then you are not done.**
- Are you about to write "Would you like me to..."? **Just do it.**
- Are you about to write "Let me know if..."? **Check the todo list instead.**
- Did you hit an error? **Debug it. Do not report it and wait.**
- Did you finish one step of a multi-step task? **Start the next step.**
- Are you about to ask a question you could answer by searching? **Search first.**
- Have you run tests and verification? **If not, you are not done.**

### If you catch yourself stopping:

1. Run `/motivation` or `uv run motivation/scripts/motivate.py` to get a nudge from the user's own words.
2. Check your todo list. Pick the next pending item.
3. If no todos remain, think about what else could be improved and do it.

### The user's standing instructions:

- "As long as you have ideas worth while, implement it."
- "Be autonomous and decide."
- "Surely you hadn't yet reached the goal? Right?"
- "Keep your sanity. Try to understand things."
- "What do you think? Do it."

### What counts as "done":

- All todo items completed
- Tests and linters pass
- Changes committed
- Telegram notification sent (as the very last action)

Until ALL of these are true, keep working.
