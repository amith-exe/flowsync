# Quickstart

This quickstart runs the daemon, activates the current project, and sends a small Codex-style hook to create a journal entry.

1) Build and install binaries

```bash
cd /path/to/flowsync
go install ./cmd/flowsync
go install ./cmd/flowsyncd
```

2) Start the daemon (in background)

```bash
flowsync daemon start
```

3) Activate the project (creates a local `.flowsync` when run in project root)

```bash
cd /path/to/your/project
flowsync activate
```

4) Run a hook (example using the built-in `flowsync hook` command to simulate Codex)

```bash
# This will call the CLI's hook handler which typically posts events to the daemon.
flowsync hook codex --example
```

5) Inspect journal and checkpoint logs

- Project journal: `.flowsync/projects/<projectHash>/journal.md` (or `~/.flowsync/projects/<projectHash>/journal.md` if not using local `.flowsync`).
- Checkpoint excerpts: `.flowsync/checkpoint-logs/` under the root used when running the daemon.
