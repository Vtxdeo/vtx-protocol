.PHONY: all check verify-wit install-tools clean link-all copy-wit-go

all: copy-wit-go check

help:
	@echo "Available commands:"
	@echo "  make check           - Validate WIT syntax"
	@echo "  make install-tools   - Install development dependencies"
	@echo "  make link-all        - Link packages locally for development"
	@echo "  make clean           - Cleanup artifacts"

check: verify-wit

copy-wit-go:
	@echo "Syncing WIT to Go package..."
	@mkdir -p packages/go/wit
	@cp wit/vtx.wit packages/go/wit/vtx.wit

verify-wit:
	@echo "[1/1] Validating WIT syntax..."
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

clean:
	@echo "Cleaning up..."
	@rm -rf target/
	@rm -rf packages/python/dist packages/python/*.egg-info
	@rm -rf packages/npm/*.tgz packages/npm/node_modules
	@rm -rf packages/rust/target
	@rm -rf packages/go/wit