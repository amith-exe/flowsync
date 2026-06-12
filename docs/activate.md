# Project Activation

`flowsync activate` prepares a project to accept hooks and journaling. By default it:

- Installs project hooks (Claude/Codex) into `.claude` or `.codex` config files.
- Starts the local daemon if not already running.
- Creates a local `.flowsync` directory when run with `--scope=project` so journal and logs can be stored next to the project.

Usage

```bash
# activate current project (default scope=project)
flowsync activate

# activate for user (installs hooks in global settings)
flowsync activate --scope user
```

Auto-activation options

- direnv (recommended): put `flowsync activate --quiet` in `.envrc` and `direnv allow`.
- git init template: add a `post-checkout` or `post-checkout` hook in a global template to run `flowsync activate` on new repos.

Local `.flowsync` layout

- `.flowsync/projects/<projectHash>/state.json` — project state and mapping to working dir
- `.flowsync/projects/<projectHash>/journal.md` — project journal entries
- `.flowsync/checkpoint-logs/` — checkpoint excerpts written by the daemon
