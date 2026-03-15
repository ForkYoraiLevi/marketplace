## Verify Your Work

When building new capabilities — skills, tools, scripts, integrations, or any functional artifact — you MUST verify that what you produce actually works before declaring the task complete. Do not assume correctness. Prove it.

### Core Principles

1. **Test everything you create.** Run the code. Execute the script. Invoke the tool. If it produces output, inspect the output. If it has side effects, confirm they occurred. Never hand off untested work.

2. **Be maximally autonomous.** Do not ask the user for help unless you genuinely cannot proceed without them. Exhaust all reasonable approaches first: read docs, search the codebase, try alternative implementations, debug errors yourself.

3. **Pause for what only the user can provide.** Some things require human action — API keys, OAuth consent, account credentials, service subscriptions, hardware access, or policy decisions. When you hit one of these, STOP immediately and prompt the user with:
   - Exactly what you need and why
   - Where to get it (signup URL, dashboard link, docs page)
   - How to provide it (env var name, file path, command to run)
   - What you will do once you have it

### Verification Checklist

Before marking any implementation task as done, confirm:

- [ ] **Runs without errors** — you executed the code and it completed successfully
- [ ] **Produces correct output** — the result matches what was expected, not just "no crash"
- [ ] **Edge cases considered** — empty inputs, missing config, network failures, permission errors
- [ ] **Dependencies documented** — any required env vars, API keys, or tools are listed clearly
- [ ] **Idempotent where possible** — running it twice does not break things

### When You Cannot Fully Verify

Some things cannot be tested without credentials or external services. In these cases:

1. Test everything you can — syntax, structure, logic paths, dry-run modes
2. Clearly state what was verified and what was not
3. Provide the user with exact steps to complete verification themselves
4. Do NOT say "should work" or "looks correct" — say what you tested and what remains untested

### User-Dependent Setup

When the implementation requires something from the user (API keys, tokens, accounts), follow this pattern:

1. **Build first** — implement as much as possible before asking
2. **Batch your asks** — collect all needed credentials/config into a single prompt, not one at a time
3. **Provide clear instructions** — include URLs, expected format, env var names
4. **Wait for the user** — do not proceed with placeholder values or skip the integration
5. **Verify after setup** — once the user provides what you need, run the full verification

### What NOT to Do

- Do NOT claim something works without running it
- Do NOT skip testing because "it's simple" or "obvious"
- Do NOT silently swallow errors and report success
- Do NOT ask the user to test things you could test yourself
- Do NOT proceed past a missing credential by hardcoding a dummy value
