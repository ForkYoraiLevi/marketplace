---
description: "Write state to disk continuously — you don't have memory, these files do"
alwaysApply: true
---

## Session Resilience

You don't have memory. These files do. Everything you learn this session is lost when it ends.

- **Treat every session as your last.** Write state to disk continuously, not just at the end.
- **HANDOFF.md is your memory.** After every meaningful change, update it with current state, what works, what's next.
- **PITFALLS.md captures lessons.** When you fix a bug or discover non-obvious behavior, write it down: symptom, cause, fix.
- **CHANGELOG.md tracks history.** One paragraph per milestone. Append-only.
- **The todo list is your plan.** If it's not in the list, it doesn't exist. If context compacts, the list survives.
- **Never assume the next agent has context.** Write as if someone with zero knowledge will continue your work.
- **The question isn't "did I complete the task?"** — it's "would the next agent thank me for how I left this project?"
