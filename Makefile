.PHONY: setup brew hooks
.PHONY: lint
.PHONY: prune

setup: brew hooks

brew:
	brew bundle

hooks:
	uv run --locked pre-commit install

lint:
	uv run --locked pre-commit run --all-files --hook-stage manual --show-diff-on-failure

prune:
	uv run --locked pre-commit gc
