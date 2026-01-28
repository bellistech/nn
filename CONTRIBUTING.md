# Contributing to nn

Thanks for your interest in contributing! nn is intentionally simple — a single bash script that does one thing well.

## Philosophy

- **Keep it simple** — This is ~900 lines of bash, not a framework
- **Zero dependencies** — Only POSIX tools + bash
- **Fast** — Should feel instant
- **Opinionated** — Not everything needs to be configurable

## Ways to Contribute

### Bug Reports

Found a bug? Open an issue with:
- Your OS and bash version (`bash --version`)
- What you expected vs what happened
- Steps to reproduce
- Any error output

### Feature Requests

Before requesting a feature, consider:
- Does it fit the "fast notes from terminal" use case?
- Can it be done with existing Unix tools instead?
- Would most users want this, or just a few?

### Pull Requests

1. Fork the repo
2. Create a branch (`git checkout -b fix/thing`)
3. Make your changes
4. Test on both Linux and macOS if possible
5. Submit PR with clear description

#### Code Style

- Use `local` for function variables
- Quote all variables: `"$var"` not `$var`
- Use `[[ ]]` for tests, not `[ ]`
- Prefer `$(command)` over backticks
- Add comments for non-obvious logic
- Keep functions focused and small

#### Testing

```bash
# Basic smoke test
./nn --help
./nn --version
./nn -a "test"
./nn -T incident test
./nn --stats
./nn -s "test"

# Test on clean state
NOTES_ROOT=/tmp/nn-test ./nn
```

### Documentation

README improvements, typo fixes, and better examples are always welcome.

## What We Probably Won't Add

- GUI or TUI interface
- Database backend
- Cloud sync (use git + your own remote)
- Plugin system
- Config files (use environment variables)
- Non-bash implementations

## Questions?

Open an issue or discussion. Keep it friendly.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
