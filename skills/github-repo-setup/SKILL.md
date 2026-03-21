---
name: github-repo-setup
description: Create a GitHub repo with CI, branch protection, and naming rules
argument-hint: "[visibility] [description]"
allowed-tools:
  - exec
  - read
  - edit
  - glob
  - grep
permissions:
  allow:
    - Exec(gh)
    - Exec(git)
    - Exec(bash)
    - Exec(uv run)
triggers:
  - user
---

# GitHub Repo Setup

Create a GitHub repository from a local git repo and configure it with CI workflows, branch protection rulesets, and branch naming conventions — all via the `gh` CLI.

## Prerequisites

- **gh** must be installed and authenticated (`gh auth status` should succeed)
- **git** repo must exist in the current directory with at least one commit
- Required `gh` token scopes: `repo`, `workflow`

If `gh` is not authenticated, tell the user:
```
gh auth login
```

## What It Configures

1. **GitHub repository** — creates from local git, sets `main` as default branch
2. **CI workflow** — detects project language and generates `.github/workflows/ci.yml`
3. **Branch protection rulesets** via GitHub API:
   - `main` — PR required, CI status checks, no deletion, no force push, linear history
   - `pub/**` — PR required, CI status checks, no deletion, no force push
   - `pvt/**` — no deletion, no force push (direct push allowed)
4. **Branch naming convention** — only allows: `main`, `usr/<user>/<topic>`, `pvt/<topic>`, `pub/<topic>`

## Usage

```
bash $SKILL_DIR/scripts/setup_repo.sh [options]
```

### Options

- `--visibility <public|private>` — repo visibility (default: public)
- `--description "<text>"` — repo description
- `--no-ci` — skip CI workflow generation (just create repo + rulesets)
- `--no-rulesets` — skip branch protection rulesets
- `--dry-run` — show what would be done without making changes

## Instructions

### Step 1: Verify prerequisites

Run the script with no arguments to check prerequisites:
```
bash $SKILL_DIR/scripts/setup_repo.sh --dry-run
```

### Step 2: Detect project type and plan CI

Before running, examine the project to determine the language and build system:
- **Rust** (Cargo.toml): fmt, clippy, test, build
- **Python** (pyproject.toml / setup.py): ruff, mypy, pytest
- **Node.js** (package.json): lint, typecheck, test, build
- **Go** (go.mod): vet, staticcheck, test, build

If the project has an existing Makefile with quality targets, prefer those commands.

If the project does not have a Makefile, generate one with these conventions:
- `.DEFAULT_GOAL := help` — bare `make` shows help
- `help` target that dynamically lists all targets with descriptions
- Each target uses `## description` after the colon for self-documenting help
- Pattern: `target: deps ## Short description`

Example Makefile template:
```makefile
.PHONY: help install lint format test check clean

.DEFAULT_GOAL := help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	...

lint: ## Run linter
	...

test: ## Run tests
	...

check: lint test ## Run all quality checks
	...

clean: ## Remove build artifacts
	...
```

### Step 3: Run the setup

```
bash $SKILL_DIR/scripts/setup_repo.sh --visibility public --description "Project description"
```

### Step 4: Verify

After setup, verify:
1. The repo exists on GitHub: `gh repo view`
2. CI passes: `gh run list --limit 1`
3. Rulesets are active: `gh api repos/{owner}/{repo}/rulesets`

### Step 5: Report

Tell the user:
- Repository URL
- CI jobs configured and their status
- Rulesets created and what they enforce
- Branch naming rules

## Language-Specific CI Templates

The script generates CI based on detected language. If the project uses a language not listed, ask the user what CI steps to include.

### Rust
Jobs: `fmt` (cargo fmt --check), `clippy` (cargo clippy -D warnings), `test` (cargo test), `build` (cargo build)

### Python (uv)
Jobs: `lint` (ruff check + ruff format --check), `typecheck` (mypy), `test` (pytest)

### Node.js
Jobs: `lint` (npm run lint), `typecheck` (npm run typecheck), `test` (npm test), `build` (npm run build)

### Go
Jobs: `vet` (go vet), `lint` (staticcheck), `test` (go test), `build` (go build)

## Error Handling

- If the repo already exists on GitHub, ask the user whether to add a remote and push, or abort.
- If `gh` lacks required scopes, tell the user to re-authenticate: `gh auth refresh -s repo,workflow`
- If CI generation fails, still proceed with repo creation and rulesets.
- If a ruleset creation fails, report the error and continue with remaining rulesets.

User arguments: $ARGUMENTS
