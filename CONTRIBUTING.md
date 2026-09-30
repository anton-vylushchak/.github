# Contributing

Every change lands through a pull request.

## One-time setup

```bash
make setup
```

## Making a change

```bash
git switch -c <branch>
# edit, then commit: the hooks run
git push -u origin HEAD
gh pr create --fill-first
```

Merge only once the checks pass. GitHub Free doesn't enforce required checks on private repos, so nothing else blocks a
merge on red.

The pull request title must follow Conventional Commits: squash merges turn it into the commit on `main`, and the PR
title check fails otherwise. `--fill-first` takes the title from the branch's first commit, which the commit-message
hook has already checked.

## Manual maintenance

Bump every check in [.pre-commit-config.yaml](.pre-commit-config.yaml) to its latest release:

```bash
uv run pre-commit autoupdate
```

Bump pre-commit itself:

```bash
uv add --dev pre-commit==<version>
```

Reclaim disk after a bump. The superseded hook environment stays in the cache, and a gitleaks or actionlint bump leaves
about 320 MB behind because those hooks compile from source:

```bash
make prune
```

Skip one check for a single commit with `SKIP=<hook-id> git commit`, or all of them with `--no-verify`. The hooks guard
against slips; they can't stop a deliberate bypass.
