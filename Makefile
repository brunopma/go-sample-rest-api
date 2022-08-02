BASE_PATH        := $(shell pwd | sed 's/ /\\ /g')
BASE_PACKAGE_SRC := .
MAIN_FILE        := .
TARGET_BIN       := CHANGEME
.DEFAULT_GOAL := help

GITHUB_USER := CHANGEME
GITHUB_REPOSITORY_NAME := CHANGEME


.PHONY: help

help:
	@grep -E --no-filename '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Installs dependencies with go mod
	@cd $(BASE_PACKAGE_SRC)
	docker compose build
	docker compose run --rm app go mod init github.com/$(GITHUB_USER)/$(GITHUB_REPOSITORY_NAME)

run: ## Starts go in develop mode with hot-reload and debug
	GO_COMMAND="air" docker compose up

debug: ## Starts go in develop mode with hot-reload and debug
	GO_COMMAND="dlv debug --headless --listen=:2345 --api-version=2 cmd/main.go" docker compose up




build-macos: ## Builds binaries. places them into bin/
	@mkdir -p bin
	@cd $(BASE_PACKAGE_SRC) && GOOS=darwin GOARCH=amd64 go build -o $(TARGET_BIN) $(MAIN_FILE)
	@mv $(BASE_PACKAGE_SRC)/$(TARGET_BIN) bin/$(TARGET_BIN)-macos-amd64

build-windows: ## Builds binaries for windows-amd64 platform, places them into bin/
	@mkdir -p bin
	@cd $(BASE_PACKAGE_SRC) && GOOS=windows GOARCH=amd64 go build -o $(TARGET_BIN) $(MAIN_FILE)
	@mv $(BASE_PACKAGE_SRC)/$(TARGET_BIN) bin/$(TARGET_BIN)-win-amd64

build-linux: ## Builds binaries for linux-amd64 platform, places them into bin/
	@mkdir -p bin
	@cd $(BASE_PACKAGE_SRC) && GOOS=linux GOARCH=amd64 go build -o $(TARGET_BIN) $(MAIN_FILE)
	@mv $(BASE_PACKAGE_SRC)/$(TARGET_BIN) bin/$(TARGET_BIN)-linux-amd64