# Contributing

Thanks for wanting to contribute to FlowSync! Please follow these guidelines:

1. Open an issue describing the problem or feature before implementing large changes.
2. Create a topic branch for your work: `git checkout -b feat/your-idea`.
3. Keep changes small and focused; write tests where appropriate.
4. Run `go test ./...` and ensure CI passes before submitting a PR.
5. Add documentation to `docs/` for new user-facing behavior.

Code style
- Use idiomatic Go (gofmt, vet). Avoid global side-effects.

License
- This project uses the LICENSE in the repository root.
