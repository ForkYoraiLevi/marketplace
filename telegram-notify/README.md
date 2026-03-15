# telegram-notify

Send Telegram notifications from the command line or an AI agent session using the [Telegram Bot API](https://core.telegram.org/bots/api).

Useful as a "ping me when you're done" skill — the agent sends a concise task summary to your Telegram when it finishes working.

## Setup

Run the interactive setup script — it handles everything:

```bash
uv run scripts/setup.py
```

The script will:
1. Walk you through creating a bot via [@BotFather](https://t.me/BotFather)
2. Validate your bot token
3. Auto-detect your chat ID (asks you to message the bot, then polls for it)
4. Send a test message to confirm it works
5. Optionally append the credentials to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.)

### Manual setup

If you prefer to set things up manually:

1. Message [@BotFather](https://t.me/BotFather) on Telegram, send `/newbot`, and copy the token.
2. Message your new bot, then find your chat ID:
   ```bash
   curl -s "https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates" | python3 -m json.tool
   ```
   Look for `"chat": {"id": 12345678, ...}` in the response.
3. Export both values:
   ```bash
   export TELEGRAM_BOT_TOKEN="123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
   export TELEGRAM_CHAT_ID="12345678"
   ```

## Usage

The script is self-contained with zero dependencies (PEP 723, stdlib only). No install step needed:

```bash
uv run scripts/send_telegram.py --message "Hello from the terminal!"
```

### Options

| Flag | Required | Description |
|------|----------|-------------|
| `--message` / `-m` | Yes | Message text to send (max 4096 chars, auto-truncated) |
| `--parse-mode` | No | `Markdown`, `MarkdownV2`, or `HTML` (default: plain text) |
| `--chat-id` | No | Override `TELEGRAM_CHAT_ID` env var |
| `--token` | No | Override `TELEGRAM_BOT_TOKEN` env var |

### Examples

```bash
# Simple notification
uv run scripts/send_telegram.py -m "Build finished successfully"

# With Markdown formatting
uv run scripts/send_telegram.py -m "Deploy *complete* for \`main\`" --parse-mode Markdown
```

## As an Agent Skill

Copy the `telegram-notify/` directory into your agent's skills directory:

```bash
# Global (available everywhere)
cp -r telegram-notify/ ~/.config/cognition/skills/telegram-notify/
# or: cp -r telegram-notify/ ~/.windsurf/skills/telegram-notify/

# Project-specific
cp -r telegram-notify/ /path/to/project/.cognition/skills/telegram-notify/
# or: cp -r telegram-notify/ /path/to/project/.windsurf/skills/telegram-notify/
```

Then invoke with `/telegram-notify` in a session, or let the agent call it autonomously when it finishes a task.
