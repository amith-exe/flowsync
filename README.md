# FlowSync

FlowSync is a lightweight developer tool and daemon for capturing interactive coding sessions, tool calls, and automated checkpoints into per-project journals. It integrates with local harnesses (Codex, Claude, etc.) via simple hook scripts and persists short checkpoint excerpts and richer journal entries for later inspection or compaction.

Key goals

- Make interactive code-refinement sessions auditable and reproducible.
- Persist checkpoint excerpts and human-readable journals beside projects when desired.
- Support multiple harnesses via simple adapters and hook scripts.

Features

- Per-project journaling (`journal.md`) and checkpoint excerpts.
- Pluggable reflector (defaults to `ollama` + `qwen2.5-coder:7b`).
- Project-local storage via `<repo>/.flowsync` (created by `flowsync activate`).
- Hook adapters for Codex and Claude-style harnesses.

Quick overview

1. Build and install binaries:

```bash
cd /path/to/flowsync
go install ./cmd/flowsync
go install ./cmd/flowsyncd
```

2. Start the daemon (default root `~/.flowsync`):

```bash
flowsync daemon start
```

3. Activate a project (creates a local `.flowsync` when run in the repo root):

```bash
cd /path/to/your/repo
flowsync activate
```

4. Use your harness (Codex/Claude). Hooks will send events to the daemon which writes checkpoint excerpts and appends journal entries.

Where data is stored

- Global root (default): `~/.flowsync`
- Per-project local root (when activated in project): `<repo>/.flowsync`

Important paths

- `<root>/projects/<projectHash>/state.json` — project mapping and state
- `<root>/projects/<projectHash>/journal.md` — project journal (human readable)
- `<root>/checkpoint-logs/` — short checkpoint excerpt files written at each checkpoint

Activation & auto-activation

- Run `flowsync activate` inside a project to install hooks and create the local `.flowsync` folder.
- Auto-activation options are covered in `docs/activate.md`. Two common approaches are:
  - `direnv`: put `flowsync activate --quiet` in `.envrc` and `direnv allow`.
  - Git init template hooks: add a `post-checkout` hook in a global template to call `flowsync activate` for newly initialized repos.

Managing the daemon

- Check status: `flowsync daemon status`
- Stop: `flowsync daemon stop`

Documentation

- See the `docs/` folder for detailed guides: `docs/quickstart.md`, `docs/installation.md`, `docs/activate.md`, `docs/usage.md`, `docs/cli-reference.md`, `docs/architecture.md`, and `docs/development.md`.

Contributing

- See `docs/CONTRIBUTING.md` for development and contribution guidelines.

License

- This repository uses the license in `LICENSE` at the repo root.

If you'd like, I can expand any of the `docs/` pages with examples, screenshots, or a generated documentation site.
