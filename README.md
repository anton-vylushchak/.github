# .github

Shared repository scaffolding: pre-commit checks, reusable workflows, automated releases, Dependabot configuration and
agent instructions.

## New repository

Create a new repository from this one with **Use this template**, then:

1. Set `name` in [pyproject.toml](pyproject.toml) and run `uv lock`.
2. Run `make setup` to install the tools and the git hooks.
3. Switch to the shared workflows: replace `lint.yaml` and `pr-title.yaml` in `.github/workflows/` with their callers
   from [workflow-templates/](workflow-templates/), then delete `workflow-templates/` and its entry in
   [dependabot.yaml](.github/dependabot.yaml).
4. In [.cliff.toml](.cliff.toml), set `include_paths` to what the repository releases, or remove it to release every
   change.
5. Replace this README and [LICENSE](LICENSE) with ones for the new repository.

> [!NOTE]
> Changes made here don't reach repositories already created from this template: a template is copied once, with no link
> back. The reusable workflows are the exception: repositories call them by version, and Dependabot proposes each new
> version.

## Workflows

Other repositories call these workflows by version. Copy the caller from [workflow-templates/](workflow-templates/),
which Dependabot keeps on the latest release. Each workflow lists its inputs and their defaults under `workflow_call`;
set them with `with:` on the job that calls it.

Each workflow checks out the calling repository and runs that repository's own tools, so the repository needs the files
listed in its section. With pre-commit-uv in `uv.lock`, the Python hooks install faster.

> [!CAUTION]
> Leave `concurrency` out of calling workflows. Each workflow sets its own, and a matching group in the caller cancels
> the run.

### Lint

[lint.yaml](.github/workflows/lint.yaml) runs the same pre-commit checks as `make lint` on pull requests and on pushes
to `main`. It needs:

- `uv.lock` with pre-commit
- `.pre-commit-config.yaml`

### PR Title

[pr-title.yaml](.github/workflows/pr-title.yaml) checks that the pull request title follows Conventional Commits, since
squash merges turn the title into the commit on `main`. Its caller also listens for `edited`, so the check runs again
when the title changes. It needs:

- `uv.lock` with pre-commit
- `.pre-commit-config.yaml` with the `conventional-pre-commit` hook
