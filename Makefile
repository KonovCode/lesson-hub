.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: cs-check
cs-check: ## Check coding standards
	vendor/bin/php-cs-fixer fix --dry-run --diff --verbose

.PHONY: cs-fix
cs-fix: ## Fix coding standards
	vendor/bin/php-cs-fixer fix --verbose

.PHONY: phpstan
phpstan: ## Run PHPStan static analysis
	vendor/bin/phpstan analyse --memory-limit=1G

.PHONY: qa
qa: cs-check phpstan ## Run all quality assurance checks
