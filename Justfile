# https://just.systems/man/en/

# List the recipes in the order they appear here.
[private]
default:
    @just --list --unsorted

# Install the git hooks.
setup:
    uv run --locked pre-commit install

# Run the checks as CI does, or only the given hook.
lint hook="":
    uv run --locked pre-commit run {{ hook }} \
        --all-files \
        --hook-stage manual \
        --show-diff-on-failure

# Remove hook environments that are no longer used.
prune:
    uv run --locked pre-commit gc
