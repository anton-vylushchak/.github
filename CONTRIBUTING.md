# Contributing

Every change lands through a pull request.

## Setup

```bash
brew bundle
just setup
```

This installs the tools in the [Brewfile](Brewfile), then the git hooks and gh extensions. Run `just` to list the other
recipes.

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

Merging releases a new version when the pull request calls for one under [.cliff.toml](.cliff.toml): its title has one
of the types listed there, and it changes files under `include_paths`. `!` after the type, such as `feat!:`, releases a
major version, `feat` a minor, and the other types a patch.

## Freeing disk space

A hook update leaves the old hook environment in the cache, and each Go hook keeps the 270 MB Go toolchain that built
it. Remove both with:

```bash
just prune
```
