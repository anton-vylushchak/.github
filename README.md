# .github

Shared repository scaffolding: pre-commit checks, reusable workflows, Dependabot configuration and agent instructions.

## New repository

Create a new repository from this one with **Use this template**, then:

1. Set `name` in [pyproject.toml](pyproject.toml) and run `uv lock`.
2. Run `make setup` to install the tools and the git hooks.
3. Switch to the shared workflows:
   1. Replace each file in `.github/workflows/` with the file of the same name in
      [workflow-templates/](workflow-templates/), so the repository calls the shared workflow instead of keeping a copy.
   2. Delete `workflow-templates/`.
   3. Remove `/workflow-templates` from [dependabot.yaml](.github/dependabot.yaml).
4. Replace this README with one for the new repository.
5. Delete anything the new repository doesn't need.

Changes made here do not reach repositories already created from it — a template is copied once, with no link back. The
reusable workflows are the exception: repositories call them by version, and Dependabot proposes each new version.

## Workflows

Other repositories call these workflows by version. Copy the caller from [workflow-templates/](workflow-templates/),
which Dependabot keeps on the latest release. Each workflow lists its inputs and their defaults under `workflow_call`;
set them with `with:` on the job that calls it.

Each workflow checks out the calling repository and runs that repository's own tools, so the repository needs the files
listed in its section. Leave `concurrency` out of calling workflows: each workflow sets its own, and a matching group in
the caller cancels the run.

### Lint

[lint.yaml](.github/workflows/lint.yaml) runs the same pre-commit checks as `make lint` on pull requests and on pushes
to `main`. It needs:

- `uv.lock` with pre-commit
- `.pre-commit-config.yaml`

### PR Title

[pr-title.yaml](.github/workflows/pr-title.yaml) checks that the pull request title follows Conventional Commits, since
squash merges turn the title into the commit on `main`. Its caller lists the `opened`, `edited`, `synchronize` and
`reopened` event types, so the check runs again when the title or the branch changes. It needs:

- `uv.lock` with pre-commit
- `.pre-commit-config.yaml` with the `conventional-pre-commit` hook
