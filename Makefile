.PHONY: all check verify-wit install-tools clean link-all
.PHONY: copy-wit-go copy-wit-java copy-wit-python copy-wit-rust copy-wit-npm
.PHONY: test-all test-rust test-npm test-python test-go test-java

all: copy-wit-go copy-wit-java copy-wit-rust copy-wit-npm check

help:
	@echo "Available commands:"
	@echo "  make check           - Validate WIT syntax and run all tests"
	@echo "  make test-rust       - Run Rust integrity tests"
	@echo "  make test-npm        - Run Node.js integrity tests"
	@echo "  make test-python     - Run Python integrity tests"
	@echo "  make test-go         - Run Go integrity tests"
	@echo "  make test-java       - Run Java integrity tests"

check: verify-wit test-all

verify-wit:
	@echo "[Check] Validating WIT syntax..."
	@if ! command -v wasm-tools > /dev/null; then echo "Error: wasm-tools not found."; exit 1; fi
	@wasm-tools component wit wit/ > /dev/null
	@echo "WIT syntax is valid."

copy-wit-go:
	@mkdir -p packages/go/wit
	@cp wit/vtx.wit packages/go/wit/vtx.wit

copy-wit-java:
	@mkdir -p packages/java/src/main/resources/wit
	@cp wit/vtx.wit packages/java/src/main/resources/wit/vtx.wit

copy-wit-python:
	@mkdir -p packages/python/vtx_protocol/wit
	@cp wit/vtx.wit packages/python/vtx_protocol/wit/

copy-wit-rust:
	@echo "Syncing WIT to Rust package..."
	@mkdir -p packages/rust/wit
	@cp wit/vtx.wit packages/rust/wit/vtx.wit

copy-wit-npm:
	@mkdir -p packages/npm/wit
	@cp wit/vtx.wit packages/npm/wit/vtx.wit

test-rust: copy-wit-rust
	@echo "-> [Rust] Testing..."
	@cd packages/rust && cargo test --quiet

test-npm: copy-wit-npm
	@echo "-> [NPM] Testing..."
	@cd packages/npm && npm install --silent --no-progress && npm test

test-python: copy-wit-python
	@echo "-> [Python] Testing..."
	@cd packages/python && python3 -m unittest discover tests

test-go: copy-wit-go
	@echo "-> [Go] Testing..."
	@cd packages/go && go test -v .

test-java: copy-wit-java
	@echo "-> [Java] Testing..."
	@cd packages/java && mvn test -q

test-all: test-rust test-npm test-python test-go test-java
	@echo "All integrity checks passed."

install-tools:
	@if ! command -v wasm-tools > /dev/null; then cargo install wasm-tools; fi

clean:
	@echo "Cleaning up..."
	@rm -rf target/
	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/wit
	@rm -rf packages/npm/*.tgz packages/npm/node_modules packages/npm/wit
	@rm -rf packages/rust/target packages/rust/wit
	@rm -rf packages/go/wit
	@rm -rf packages/java/target packages/java/src/main/resources/wit