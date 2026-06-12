#!/usr/bin/env bash
set -euo pipefail
WORKDIR=$(mktemp -d)
TRANSCRIPT="$WORKDIR/transcript.jsonl"
echo "workdir: $WORKDIR"
cat > "$WORKDIR/prompt.json" <<'JSON'
{"session_id":"flowsync-live","transcript_path":"%TRANS%","cwd":"%CWD%","permission_mode":"default","hook_event_name":"UserPromptSubmit","prompt":"Please write a short summary of the project and a suggested next action."}
JSON
sed -i "s|%TRANS%|$TRANSCRIPT|g; s|%CWD%|$WORKDIR|g" "$WORKDIR/prompt.json"
cat > "$WORKDIR/stop.json" <<'JSON'
{"session_id":"flowsync-live","transcript_path":"%TRANS%","cwd":"%CWD%","permission_mode":"default","hook_event_name":"Stop","last_assistant_message":"Done"}
JSON
sed -i "s|%TRANS%|$TRANSCRIPT|g; s|%CWD%|$WORKDIR|g" "$WORKDIR/stop.json"

# send prompt
cat "$WORKDIR/prompt.json" | THREADMARK_BIN=~/bin/flowsync THREADMARK_ROOT=$HOME/.flowsync ~/bin/flowsync hook claude-code --root $HOME/.flowsync --socket $HOME/.flowsync/daemon.sock --strict --timeout 60s || true
sleep 1
# send stop
cat "$WORKDIR/stop.json" | THREADMARK_BIN=~/bin/flowsync THREADMARK_ROOT=$HOME/.flowsync ~/bin/flowsync hook claude-code --root $HOME/.flowsync --socket $HOME/.flowsync/daemon.sock --strict --timeout 60s || true
sleep 6

echo '--- daemon.log (tail 200) ---'
tail -n 200 $HOME/.flowsync/daemon.log || true

echo '--- recent files in projects ---'
find $HOME/.flowsync/projects -maxdepth 3 -type f -printf '%T@ %p\n' | sort -n | tail -n 40 || true

echo '--- list project dirs ---'
ls -la $HOME/.flowsync/projects || true

echo 'workdir:' $WORKDIR
