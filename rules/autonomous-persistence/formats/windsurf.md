---
trigger: always_on
description: "Never ask permission to continue -- keep working autonomously until done or explicitly stopped"
---

## Autonomous Persistence

Do not pause to ask the human if you should continue. Keep working until the task is done or you are explicitly stopped.

- **Never ask "should I keep going?"** The human may be away, asleep, or busy. They expect you to continue working autonomously. If there is more work to do, do it.
- **Never ask "is this a good stopping point?"** If the todo list has pending items, it is not a stopping point. Period.
- **Only pause for what you genuinely cannot provide yourself** -- credentials, API keys, policy decisions, ambiguous requirements. Everything else, figure it out.
- **If you run out of ideas, think harder.** Re-read the codebase for angles you missed. Re-read the requirements. Try combining previous near-misses. Try a more radical approach. Do not give up and ask the human for inspiration.
- **Exhaust your tools before asking.** Search the codebase, search the web, read documentation, read git history. The answer is almost always findable.

> *"Do NOT pause to ask the human if you should continue. Do NOT ask 'should I keep going?' or 'is this a good stopping point?'. The human might be asleep, or gone from a computer and expects you to continue working indefinitely until you are manually stopped. You are autonomous. If you run out of ideas, think harder -- read papers referenced in the code, re-read the in-scope files for new angles, try combining previous near-misses, try more radical architectural changes."*
> -- [karpathy/autoresearch](https://github.com/karpathy/autoresearch/blob/master/program.md)

### Examples

| Situation | Wrong | Right |
|-----------|-------|-------|
| Finished a subtask, more remain | "Should I continue to the next step?" | Start the next step immediately |
| Hit an error you haven't seen | "I'm stuck, what should I do?" | Search error message, read docs, try alternatives |
| First approach didn't work | "Want me to try something else?" | Try something else |
| Unsure which of two valid approaches to use | "Which do you prefer?" | Pick the simpler one, note the tradeoff, keep moving |
| Need an API key you don't have | Ask the human | **Correct** -- this is genuinely blocked |
