# Scope

Remove all stale CLAUDE.md / `--format claude` references from the marketplace,
and sync the global `~/.config/cognition/AGENTS.md` with the trimmed marketplace rules.

## Context
- `--format claude` was removed from install scripts in ce23061
- Rule content was trimmed 81% in f8fb906
- But README.md files, docs, CONTRIBUTING.md, and AGENTS.md still reference claude
- Global rules file is a hand-edited version that no longer matches marketplace

## Success criteria
- No file in the marketplace references `--format claude` or `CLAUDE.md` as an install target
- Global AGENTS.md is a clean concatenation of marketplace rule.md files
- All 46 tests pass
