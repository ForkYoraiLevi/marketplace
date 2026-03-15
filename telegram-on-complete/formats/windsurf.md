---
trigger: always_on
description: "Send a Telegram notification after completing any task"
---

## Telegram on Complete

After completing any task, send a Telegram notification as your LAST action.

```
uv run telegram-notify/scripts/send_telegram.py -m "<summary>"
```

If `TELEGRAM_BOT_TOKEN` or `TELEGRAM_CHAT_ID` are not set, run setup first:
```
uv run telegram-notify/scripts/setup.py
```

**Before notifying, ALL must be true:** code saved, tests pass, commits made, verification done, no remaining todos.

**When to notify:** after completing work, after long operations finish, when blocked on user input, when asking a question. NOT for mid-task progress.
