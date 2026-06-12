# Usage and Examples

Inspecting projects and logs

- Project store (global): `~/.flowsync/projects/<projectHash>/`.
- Local project store (when activated): `<repo>/.flowsync/projects/<projectHash>/`.
- Checkpoint excerpts: `<root>/checkpoint-logs/`.

Example: find the journal for a repo path

```bash
# from any location
python - <<'PY'
import json,glob,sys
for path in glob.glob('~/.flowsync/projects/*/state.json'):
    try:
        s=json.load(open(path))
        if s.get('working_dir')==sys.argv[1]:
            print(path.replace('state.json','journal.md'))
    except Exception:
        pass
PY /abs/path/to/your/repo
```

Common workflows

- Run interactive Codex/Claude sessions via your harness; hooks will create checkpoints which the daemon stores.
- Use `flowsync daemon status` and `flowsync daemon stop` to manage the daemon.

Inspect the journal manually:

```bash
cat ~/.flowsync/projects/<projectHash>/journal.md
# or if local .flowsync was used
cat .flowsync/projects/<projectHash>/journal.md
```
