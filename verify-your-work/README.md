# verify-your-work

A rule that requires AI agents to test and verify everything they build before declaring a task complete. Agents must be maximally autonomous — solving problems themselves — but must pause and prompt the user when credentials, API keys, or other human-dependent setup is required.

## What It Enforces

- **Test before you ship** — agents must run their code, inspect output, and confirm correctness
- **Be autonomous** — exhaust all reasonable approaches before asking the user for help
- **Pause for human-dependent setup** — when API keys, OAuth tokens, or account access is needed, stop and prompt the user with clear instructions on what to provide and how
- **No untested claims** — agents must say what they verified and what they could not, never "should work"

## Quick Install

```bash
git clone https://github.com/yorai/marketplace.git
cd marketplace
./verify-your-work/install.sh           # current project
./verify-your-work/install.sh --global  # all projects
```

## Manual Install

### Devin / AGENTS.md

Append the contents of `rule.md` to your project's `AGENTS.md` (or `~/.config/cognition/AGENTS.md` for global).

### Windsurf

```bash
cp verify-your-work/formats/windsurf.md .windsurf/rules/verify-your-work.md
```

### Cursor

```bash
cp verify-your-work/formats/cursor.md .cursor/rules/verify-your-work.md
```

### Claude Code

Append the contents of `rule.md` to your `CLAUDE.md` (or `~/.claude/CLAUDE.md` for global).

## How It Works

This is a **rule**, not a skill. It adds behavioral instructions that the AI agent follows during every session. There is no runtime code — just Markdown that shapes agent behavior.

See [Rule Format](../docs/RULE_FORMAT.md) for details on the rule system.
