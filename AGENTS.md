# AGENTS.md

## Conventions

- **Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)** for commit and pull request titles.
  The pull request title becomes the commit on `main`, and a `feat`, `fix`, `perf` or `!` title releases a new version
  (see [CONTRIBUTING.md](CONTRIBUTING.md#releases)).
- **Run `just lint` before handing over changes.** It runs the same checks as CI.
- **Never bypass git hooks** with `--no-verify` or `SKIP`.
- **Pin exact versions.** Actions use full version tags such as `actions/checkout@v7.0.1`, and images use explicit
  version tags. Never use commit SHAs, floating tags such as `@v7`, or `latest`. Dependabot keeps the pins up to date.
- **Checks and their versions live in `.pre-commit-config.yaml`.** Tools the repo runs, including pre-commit itself,
  live in `pyproject.toml` and `uv.lock`. Don't pin tool versions in the `Justfile` or in workflows.
- **Tool config lives in a root dotfile**, such as `.yamllint.yaml`, not in hook `args`.
- **Use `.yaml` for YAML files**, unless a tool only recognizes `.yml`.
