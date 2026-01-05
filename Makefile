.PHONY: all check verify-wit install-tools clean link-all copy-wit-go copy-wit-java test-all

all: copy-wit-go copy-wit-java check

help:
	@echo "Available commands:"
	@echo "  make check           - Validate WIT syntax and run integrity tests"
	@echo "  make install-tools   - Install development dependencies"
	@echo "  make link-all        - Link packages locally for development"
	@echo "  make clean           - Cleanup artifacts"

check: verify-wit test-all

copy-wit-go:
	@echo "Syncing WIT to Go package..."
	@mkdir -p packages/go/wit
	@cp wit/vtx.wit packages/go/wit/vtx.wit

copy-wit-java:
	@echo "Syncing WIT to Java package..."
	@mkdir -p packages/java/src/main/resources/wit
	@cp wit/vtx.wit packages/java/src/main/resources/wit/vtx.wit

verify-wit:
	@echo "[1/2] Validating WIT syntax..."
	@if ! command -v wasm-tools > /dev/null; then echo "Error: wasm-tools not found. Run 'make install-tools'"; exit 1; fi
	@wasm-tools component wit wit/ > /dev/null
	@echo "WIT syntax is valid."

install-tools:
	@echo "Installing dependencies..."
	@if ! command -v wasm-tools > /dev/null; then cargo install wasm-tools; else echo "wasm-tools already installed"; fi
	@echo "Dependencies installed."

link-all:
	@echo "Linking packages locally..."
	@cd packages/npm && npm link
	@echo "  -> NPM package linked."
	@cd packages/python && pip install -e .
	@echo "  -> Python package installed in editable mode."
	@cd packages/go && go mod tidy
	@echo "  -> Go module initialized."
	@cd packages/java && mvn clean install -DskipTests
	@echo "  -> Java package installed to local Maven repo."

test-all: copy-wit-go copy-wit-java
	@echo "[2/2] Running integrity tests..."
	@echo "  -> [Rust] Testing..."
	@cd packages/rust && cargo test --quiet
	@echo "  -> [NPM] Testing..."
	@cd packages/npm && npm install --silent --no-progress && npm test
	@echo "  -> [Python] Testing..."
	@cd packages/python && python3 -m unittest discover tests
	@echo "  -> [Go] Testing..."
	@cd packages/go && go test -v .
	@echo "  -> [Java] Testing..."
	@cd packages/java && mvn test -q
	@echo "All integrity checks passed."

clean:
	@echo "Cleaning up..."
	@rm -rf target/
	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/generated
	@rm -rf packages/npm/*.tgz packages/npm/node_modules
	@rm -rf packages/rust/target
	@rm -rf packages/go/wit
	@rm -rf packages/java/target packages/java/src/main/resources/wit