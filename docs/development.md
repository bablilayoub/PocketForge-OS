# Development Workflow

PocketForge OS is in early alpha, so the project favors fast local iteration
over running expensive image builds on every commit.

## Local Checks

Run this before committing or pushing active development work:

```bash
scripts/check-local
```

This validates YAML, JSON, shell scripts, PocketForge profile schemas, and the
current daemon smoke test.

## GitHub Actions

- `Validate project files` runs on pull requests and can be started manually.
- `Build container image` runs manually and once weekly as a safety build.
- `Build disk images` runs manually only.

During heavy development, batch related changes locally, run `scripts/check-local`,
then manually run the full image build when the runtime or image layout changes.
