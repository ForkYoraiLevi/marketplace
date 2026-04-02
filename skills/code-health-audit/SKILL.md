---
name: code-health-audit
description: Audit codebase for DRY violations, oversized files, and scattered definitions
argument-hint: "[directory]"
allowed-tools:
  - read
  - exec
  - grep
  - glob
triggers:
  - user
  - model
---

# Code Health Audit

Scan a codebase for maintainability problems and produce a prioritized refactoring plan. The goal is to identify what makes the codebase hard for a human to maintain — not style nits.

## Step 1: Read project context

Check for `CODEBASE.md` at the project root. If it exists, read it — it documents module boundaries, shared type locations, and project-specific conventions. Use this to calibrate your analysis: violations of the project's own documented structure are higher severity.

If `CODEBASE.md` doesn't exist, note this as the first finding.

## Step 2: Run the automated scan

```bash
uv run $SKILL_DIR/scripts/scan_codebase.py $1
```

Options:
- First argument: directory to scan (default: current directory)
- `--max-lines N`: line threshold for large files (default: 300)
- `--json`: output as JSON for programmatic use

The script detects:
- Files exceeding size threshold
- Definition names that appear in multiple files (potential duplication)
- Files with high definition density (many classes/functions)
- Files with generic names (`utils`, `helpers`, `misc`)
- Missing `CODEBASE.md`

## Step 3: Semantic analysis

The script catches mechanical patterns. You must also investigate:

**Scattered definitions.** For each duplicate name the script found, read the actual definitions. Are they truly the same concept defined twice? Check whether they share an import source or each define independently. Same concept in two places = critical finding.

**Hidden coupling.** Look for modules that share state through implicit means — both reading the same config file, both hardcoding the same magic string, both defining the same data shape without a shared type. These are invisible dependencies that break when one side changes.

**Responsibility overload.** For each large file, read the first 30 lines (imports and initial declarations reveal scope). List what the file actually does. If it handles N concerns, suggest N files.

**Naming clarity.** Beyond the generic names the script flags, scan for functions named `process`, `handle`, `do`, `run`, `get`, `set` without a qualifying noun. These names force readers to open the file to understand what it does.

**Architecture legibility.** Does the directory structure reflect system boundaries? Could a new developer look at top-level directories and understand what this project is? Flag things that are in surprising locations.

## Step 4: Report findings

Structure your output as:

```
## Code Health Audit — [project name]

### Critical (fix now)
Duplicate definitions, scattered constants — highest maintenance risk because
changes require updating N places and forgetting one causes bugs.

### Important (fix soon)
Oversized files, mixed responsibilities — hard to navigate and review.

### Suggestions
Naming improvements, structural reorganizations — lower risk but improve
developer experience.

### CODEBASE.md status
Missing / outdated / accurate
```

Each finding must include:
- **What**: the specific problem (e.g., "WorkflowCategory defined in 3 files")
- **Where**: exact file paths
- **Fix**: concrete action ("extract to src/types/workflow.ts, import everywhere")
- **Impact**: why it hurts ("changing a category requires editing 3 files")

## Step 5: Create action items

Convert findings into a prioritized todo list using todo_write. Order by:
1. Duplicate definitions (highest risk — silent breakage)
2. Missing CODEBASE.md (blocks future audits)
3. Oversized files (hardest to navigate)
4. Missing centralization (scattered config, magic strings)
5. Naming improvements (lowest effort, good quick wins)

User arguments: $ARGUMENTS
