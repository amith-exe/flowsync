# Development

Build and test

```bash
# build all binaries
cd /path/to/flowsync
go build ./...

# run unit tests
go test ./...
```

Common targets

- `cmd/flowsync` — developer CLI for activation and hook plumbing.
- `cmd/flowsyncd` — daemon entrypoint; runs as a background process.

Style and contributions

- Follow existing Go project layout and keep functions focused.
- Run `go fmt` and `go vet` before opening PRs.

Local debugging

- Use `./cmd/flowsyncd/flowsyncd` directly from your workspace and run `flowsync daemon stop` from another shell to trigger shutdown paths.
