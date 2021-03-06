.PHONY: clean clean-pyc help lint install-deps run-app
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT
BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

# clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts
clean: clean-pyc clean-test ## remove all build, test, coverage and Python artifacts


clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -rf .pytest_cache/

lint: ## check style with flake8
	flake8 .

install-deps: ## Install requirements
	pip install -r requirements.txt

run-app: ## Run this pathetic app
	uvicorn --reload main:app
