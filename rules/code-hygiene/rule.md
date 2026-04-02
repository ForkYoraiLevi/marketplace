## Code Hygiene

Write code a human can maintain without an AI agent.

- **Search before defining.** Before creating any type, constant, enum, or utility, grep the codebase. Import if found. Refactor to generalize if similar.
- **Centralize definitions.** Types, constants, config shapes, and enums live in dedicated files — never inline in business logic. One source of truth per concept.
- **Import, don't redefine.** If a value or type exists in the codebase, import it. Duplicate definitions are never acceptable.
- **One file, one job.** Each module has a single responsibility. If describing it requires "and," split it. Target ~300 lines max per file.
- **Name for humans.** No `utils`, `helpers`, `misc`, `processData()`. Every file, function, and variable describes its purpose without reading the implementation.
- **Refactor alongside.** When touching code, consolidate nearby duplication in the same change — not as a future task.
- **Delete dead code** on sight — unused imports, unreachable branches, orphaned functions.
- **Config over code.** If a non-developer needs to change it (data registries, feature toggles, resource lists), it belongs in a config file (YAML/JSON/TOML), not in source code.
- **Convention over configuration.** Derive behavior from existing data structures rather than maintaining parallel mappings. If the data already has grouping, read it — don't duplicate it in a separate config.
- **Centralize paths.** File paths and directory names referenced in multiple files must be defined once (e.g., in a config module) and imported everywhere. Moving a directory should require editing one line.
- **Complete the migration.** Partial reorganizations are worse than none. If you organize some files into subdirectories, organize all of them — leftovers look like mistakes.
- **Maintain `CODEBASE.md`.** Document module boundaries, shared type locations, directory purposes, and key abstractions. Update when architecture changes.
- **Structure directories.** Source in `src/`, documentation in `docs/`, scripts in `scripts/`, configuration in `config/`. Adapt to language conventions.
