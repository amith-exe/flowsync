# CLI Reference

Top-level commands

- `flowsync activate [--scope project|user]` — install project hooks and start daemon.
- `flowsync init <claude-code|codex>` — write harness-specific hooks.
- `flowsync daemon <start|stop|restart|status>` — manage the daemon.
- `flowsync hook <claude-code|codex> ...` — helper to run a hook locally (used by adapter scripts).

Daemon options (common)

- `--root` — override flowsync root directory (default `~/.flowsync`).
- `--socket` — override unix socket path.
- `--timeout` — control startup/shutdown timeouts.

See `flowsync --help` and `flowsync <subcommand> --help` for detailed flags.
