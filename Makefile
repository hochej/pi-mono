.PHONY: docs serve-docs clean-docs

ZENSICAL_VERSION ?= 0.0.21

docs:
	@./scripts/docs.sh
	@cd "$(CURDIR)" && uvx --from "zensical==$(ZENSICAL_VERSION)" zensical build

serve-docs:
	@./scripts/docs.sh
	@cd "$(CURDIR)" && uvx --from "zensical==$(ZENSICAL_VERSION)" zensical serve

clean-docs:
	@rm -rf _docs _site .cache
