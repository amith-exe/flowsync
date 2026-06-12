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

Architecture diagram

```mermaid
flowchart LR
	subgraph Local
		User[User / Harness]
		HookScript[Hook Script\nadapters/*]
		RepoFlowsync[<repo>/.flowsync]
	end

	subgraph DaemonRoot[Daemon Root (~/.flowsync)]
		Daemon[flowsyncd]\n(ingest, checkpoint, journal)
		JournalStore[(projects/<hash>/journal.md)]
		CheckpointLogs[(checkpoint-logs/*)]
		Reflector[internal/reflector\n(ollama or other)]
	end

	User --> HookScript -->|call| Daemon
	HookScript -->|optionally runs| RepoFlowsync
	Daemon --> JournalStore
	Daemon --> CheckpointLogs
	Daemon --> Reflector
	Reflector -->|writes summary| JournalStore
	RepoFlowsync -->|preferred storage| JournalStore

	style RepoFlowsync fill:#f9f,stroke:#333,stroke-width:1px
	style Daemon fill:#efe,stroke:#333,stroke-width:1px
	style Reflector fill:#eef,stroke:#333,stroke-width:1px
```

The diagram shows how hooks from a harness (Codex/Claude) or direct CLI calls feed events into the daemon. The daemon writes checkpoint excerpts and appends journal entries; it may call the `internal/reflector` to summarize or transform events using the configured LLM. When a project's local `.flowsync` exists, storage is placed next to the repo, otherwise the global `~/.flowsync` root is used.
