# Architecture

FlowSync components

- `cmd/flowsync` — CLI that provides developer-facing commands (`activate`, `init`, `daemon`, `hook`).
- `cmd/flowsyncd` — the long-running daemon that accepts events, writes checkpoint excerpts, and persists journals.
- `internal/reflector` — invokes external LLM CLIs (default: `ollama`) to build reflections.
- `internal/journal` — project store and journal writing utilities.
- `adapters/*` — harness-specific hook scripts for Claude/Codex.

Data flow

1. Hooks (from CLIs or scripts) call `flowsync hook <harness>` which posts events to the daemon.
2. The daemon ingests events and, at checkpoints, writes short excerpts to `checkpoint-logs` and appends entries to the project `journal.md`.
3. `internal/reflector` is used to summarize or transform events via LLMs.

Security and filesystem layout

- Project-specific storage prefers `<repo>/.flowsync` when present; otherwise `~/.flowsync` is used.
- Files and directories are created with strict permissions (0700/0600) to protect sensitive data.
