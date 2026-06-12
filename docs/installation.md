# Installation

Prerequisites
- Go (1.20+) for building from source.
- `ollama` if you plan to use the default reflector locally.
- Optional: `direnv` for per-project auto-activation.

Install from source (recommended for contributors)

```bash
# build and install CLI and daemon
cd /path/to/flowsync
go install ./cmd/flowsync
go install ./cmd/flowsyncd
```

Start the daemon (default root `~/.flowsync`):

```bash
flowsync daemon start
# check status
flowsync daemon status
```

Windows + WSL notes
- Prefer running the daemon inside WSL for tight Unix-socket and tooling integration.
- When running in PowerShell, use `wsl` to run helper scripts or `flowsync` installed inside WSL.

Installing Ollama (optional)
- Follow Ollama's install instructions for your OS. Ensure the `ollama` binary is on your PATH.
