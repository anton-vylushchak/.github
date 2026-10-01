# Contributing

Every change lands through a pull request.

## Setup

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

The pull request title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/): squash merges
turn it into the commit on `main`, and the PR title check fails otherwise. `--fill-first` takes the title from the
branch's first commit, which the commit-message hook has already checked.

> [!WARNING]
> On private repos, GitHub Free doesn't enforce required checks, so merge only once they pass.

## Releases

Merging releases a new version when the pull request title calls for one: `feat` releases a minor version, `fix` a
patch, and `!` after the type, such as `feat!:`, a major. Other types release nothing, and neither do changes outside
`include_paths` in [.cliff.toml](.cliff.toml).

## Freeing disk space

A hook update leaves the old hook environment in the cache, and gitleaks and actionlint leave about 320 MB each because
they compile from source. Remove the leftovers with:

```bash
make prune
```
