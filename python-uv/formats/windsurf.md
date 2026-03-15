---
trigger: always_on
description: "Use uv for all Python operations — never pip, venv, conda, or poetry"
---

## Python UV

ALWAYS use `uv` for Python. NEVER use `pip`, `pip install`, `pip3`, `python -m pip`, `virtualenv`, `venv`, `pyenv`, `conda`, or `poetry` unless the user explicitly asks.

### Running scripts

Use PEP 723 inline metadata and run with `uv run`:

```python
# /// script
# requires-python = ">=3.11"
# dependencies = ["requests", "rich"]
# ///
```

```bash
uv run script.py
```

`uv` downloads the interpreter and dependencies automatically. No virtualenv, no install step.

### Managing projects

- `uv init` to create a new project
- `uv add <package>` to add a dependency (not `pip install`)
- `uv remove <package>` to remove one
- `uv sync` to install from lockfile
- `uv run <command>` to run anything in the project environment
- `uv lock` to update the lockfile

### Creating virtualenvs

If a virtualenv is truly needed: `uv venv`. Never `python -m venv`.

### Installing tools globally

`uv tool install <package>` — not `pip install --user` or `pipx`.

### Rules

- NEVER run `pip install`. Use `uv add` for projects, inline metadata for scripts.
- NEVER create a `requirements.txt` for new projects. Use `pyproject.toml` via `uv init`.
- NEVER use `python -m venv` or `virtualenv`. Use `uv venv` if needed.
- NEVER use `pip freeze`. Use `uv lock` or `uv pip compile` if pinning is needed.
- If an existing project uses pip/requirements.txt, follow its conventions — do not migrate without asking.
