# https://just.systems/man/en/

# List the recipes in the order they appear here.
[private]
default:
    @just --list --unsorted

# Install the git hooks and gh extensions.
setup:
    uv run --locked pre-commit install
    gh extension install github/gh-stack

# Run the checks as CI does, or only the given hook.
lint hook="":
    uv run --locked pre-commit run {{ hook }} \
        --all-files \
        --hook-stage manual \
        --show-diff-on-failure

# Free the disk space the caches no longer need.
prune:
    uv run --locked pre-commit gc
    rm -rf ~/.cache/pre-commit/*/golangenv-*/.go
    uv cache prune
