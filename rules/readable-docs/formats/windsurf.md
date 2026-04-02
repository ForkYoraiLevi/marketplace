---
trigger: always_on
description: "Write documentation for humans — TL;DR readme, hand-holding guides, consistent terminology"
---

## Readable Docs

Write documentation for humans who don't already understand the system.

- **README.md is a TL;DR.** What this project is, how to install/run it, and links to detailed docs. One screen of text. Not a tutorial, not a reference manual.
- **Detailed guides live in `docs/`.** One topic per file, named for what it explains (`getting-started.md`, `deployment.md`), not for who wrote it or when.
- **Hand-hold the reader.** Guides should walk a newcomer through step by step — prerequisites, exact commands, expected output, what to do if something goes wrong. Assume the reader has no prior context.
- **Define terms once, use them consistently.** If the project has domain-specific concepts, define them in one place and use the same words everywhere. Don't alternate between synonyms.
- **Docs track code.** When behavior changes, update the relevant doc in the same commit. A doc that describes yesterday's behavior is worse than no doc.
- **Mirror code structure.** If the code has distinct modules or subsystems, the docs should explain each one. A reader should be able to go from a directory name to a doc that explains what it does.
- **No orphans.** Every doc is linked from README.md or another doc. If a document has no inbound link, it won't be found.
- **Consistency check.** Terminology, formatting, heading style, and command syntax should be uniform across all docs. Inconsistency signals neglect.
