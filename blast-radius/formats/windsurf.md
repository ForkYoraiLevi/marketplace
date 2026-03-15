---
trigger: always_on
description: "Scope changes by blast radius — prefer small atomic edits over large risky rewrites"
---

## Blast Radius

Before making any change, estimate its blast radius — how many files it touches, how complex the diff will be, and how hard it is to revert. Then scope your work accordingly.

### Estimate Before You Act

Before writing code, answer these questions:

1. **How many files will this change touch?** If more than 5, break it into smaller changes.
2. **How complex is each file change?** A one-line fix is low risk. A structural refactor is high risk.
3. **Can I revert this cleanly?** If reverting requires manual untangling, the change is too big.
4. **How long should this take?** Set an expectation. If you exceed it by 2x, stop and reassess.

### Prefer Small Atomic Changes

- ALWAYS prefer many small, isolated changes over one large change.
- Each change should be independently committable, reviewable, and revertable.
- Commit after every logical unit of work — never accumulate uncommitted changes across multiple tasks.
- One commit = one purpose. Do not mix refactors with features, or bug fixes with style changes.

### Stop and Reassess

- If a task is taking significantly longer than estimated, STOP. Do not push through.
- Report what you've done so far, what's blocking progress, and what options exist.
- If you're touching more files than expected, you likely misunderstood the scope — pause and re-plan.
- If you're working around a problem rather than solving it, that's a signal to stop.
- NEVER let a single change spiral into a rewrite. Rewrites are a separate, deliberate decision.

### Plan Before You Execute

For any change beyond a trivial fix:

1. **Read the involved files first.** Understand what exists before changing it.
2. **List the files you expect to modify.** If the list surprises you, your plan is wrong.
3. **Identify dependencies.** Know what breaks if you change X.
4. **State your approach before coding.** A one-sentence plan catches bad ideas early.

### Simplicity Over Cleverness

- Do not build tools to manage tools. Do not build abstractions for one-time problems.
- If a solution requires more scaffolding than the problem itself, choose a simpler approach.
- Every new file, function, or abstraction is maintenance debt. Justify its existence.
- When in doubt, do less. A working simple solution beats an elegant broken one.

### Know Your Limits

- Agents struggle with context gathering at scale. If the project is too large to keep an overview in context, restructure the work into smaller scopes.
- Concurrency, distributed state machines, and cross-system interactions are hard for agents. Flag these as areas needing careful human review.
- If a task requires understanding that exceeds what you can fit in context, say so. Do not guess.

### Checklist

Before starting any change:

- [ ] Estimated blast radius (files touched, complexity, time)
- [ ] Approach stated in one sentence
- [ ] Broken into atomic commits if more than a trivial fix

After completing a change:

- [ ] Each commit has one purpose
- [ ] No uncommitted work left behind
- [ ] Result matches the original estimate — or you documented why it diverged
