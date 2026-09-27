# .github

Shared repository scaffolding: pre-commit checks, reusable workflows, Dependabot configuration and agent instructions.

## New repository

Create a new repository from this one with **Use this template**, then:

1. Set `name` in [pyproject.toml](pyproject.toml) and run `uv lock`.
2. Run `make setup` to install the tools and the git hooks.
3. Replace each workflow in `.github/workflows/` with the file of the same name in
   [workflow-templates/](workflow-templates/), so the repository calls the shared workflow instead of keeping a copy.
   Then delete `workflow-templates/` and remove `/workflow-templates` from [dependabot.yml](.github/dependabot.yml).
4. Replace this README with one for the new repository.
5. Delete anything the new repository doesn't need.

Changes made here do not reach repositories already created from it — a template is copied once, with no link back. The
reusable workflows are the exception: repositories call them by version, and Dependabot proposes each new version.

## Workflows

Other repositories call these workflows by version. [workflow-templates/](workflow-templates/) has a ready-made caller
for each one.

### Lint

[lint.yml](.github/workflows/lint.yml) runs `make lint` on pull requests and on pushes to `main`. Start from
[workflow-templates/lint.yml](workflow-templates/lint.yml), which Dependabot keeps on the latest release, and set inputs
with `with:`:

```yaml
jobs:
  lint:
    uses: anton-vylushchak/.github/.github/workflows/lint.yml@vX.Y.Z
    with:
      runs-on: ubuntu-slim
      timeout-minutes: 3
```

| Input             | Default       | Description                                                                 |
| ----------------- | ------------- | --------------------------------------------------------------------------- |
| `runs-on`         | `ubuntu-slim` | Runner label. `ubuntu-slim` has 1 CPU, no Docker and a 15-minute job limit. |
| `timeout-minutes` | `3`           | Job timeout in minutes.                                                     |

The workflow checks out the calling repository and runs its `make lint` and `make prune`, so that repository needs the
Makefile, `uv.lock` and `.pre-commit-config.yaml` from this template. Leave `concurrency` out of the calling workflow:
this one already sets it, and a matching group in the caller cancels the run.
