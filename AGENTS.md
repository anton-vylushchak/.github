# AGENTS.md

## Conventions

- **Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)** for commit and pull request titles.
- **Run `make lint` before handing over changes.** It runs the same checks as CI.
- **Never bypass git hooks** with `--no-verify` or `SKIP`.
- **Pin exact versions.** Actions use full version tags such as `actions/checkout@v7.0.1`, and images use explicit
  version tags. Never use commit SHAs, floating tags such as `@v7`, or `latest`. A dependency bot keeps the pins up to
  date.
- **Checks and their versions live in `.pre-commit-config.yaml`.** Tools the repo runs, including pre-commit itself,
  live in `pyproject.toml` and `uv.lock`. Don't pin tool versions in the Makefile or in workflows.
- **Tool config lives in a root dotfile**, not in hook `args`: `.yamllint.yaml`, `.mdformat.toml`.
- **Use `.yaml` for YAML files**, unless a tool only recognizes `.yml`.
