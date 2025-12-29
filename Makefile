.PHONY: all check verify-wit verify-bindings check-packages install-tools clean help link-all

all: check

help:
	@echo "Available commands:"
	@echo "  make check           - Run all verification steps"
	@echo "  make verify-wit      - Validate WIT syntax"
	@echo "  make verify-bindings - Test binding generation"
	@echo "  make check-packages  - Verify package structures (and gen code)"
	@echo "  make install-tools   - Install development dependencies"
	@echo "  make link-all        - Link packages locally for development"
	@echo "  make clean           - Cleanup artifacts"

check: verify-wit verify-bindings check-packages

verify-wit:
	@echo "[1/3] Validating WIT syntax..."
	@if ! command -v wasm-tools > /dev/null; then echo "Error: wasm-tools not found. Run 'make install-tools'"; exit 1; fi
	@wasm-tools component wit wit/ > /dev/null
	@echo "WIT syntax is valid."

verify-bindings:
	@echo "[2/3] Testing binding generation compatibility..."
	@mkdir -p target/gen-test

	@echo "  -> Testing Rust generator..."
	@wit-bindgen rust wit/ --out-dir target/gen-test/rust

	@echo "  -> Testing C generator..."
	@wit-bindgen c wit/ --out-dir target/gen-test/c

	@echo "Bindings generation successful."

check-packages: check-rust check-npm check-python

check-rust:
	@echo "[3/3] Checking Rust package..."
	@mkdir -p packages/rust/wit
	@cp wit/vtx.wit packages/rust/wit/
	@cd packages/rust && cargo check --quiet
	@rm -rf packages/rust/wit
	@echo "  -> Rust package OK"

check-npm:
	@echo "[3/3] Checking NPM package..."
	@mkdir -p packages/npm/wit
	@cp wit/vtx.wit packages/npm/wit/
	@echo "  -> Generating TypeScript definitions..."
	@cd packages/npm && npm install --silent && npm run build
	@cd packages/npm && npm pack --dry-run > /dev/null
	@echo "  -> NPM package OK"

check-python:
	@echo "[3/3] Checking Python package..."
	@mkdir -p packages/python/vtx_protocol/wit
	@cp wit/vtx.wit packages/python/vtx_protocol/wit/
	@echo "  -> Generating Python bindings..."
	@rm -rf packages/python/vtx_protocol/generated
	@mkdir -p packages/python/vtx_protocol/generated
	@componentize-py --wit-path wit --world plugin bindings packages/python/vtx_protocol/generated

	@echo "  -> Building Python package..."
	@cd packages/python && python3 -m build --sdist > /dev/null 2>&1

	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/wit packages/python/vtx_protocol/generated
	@echo "  -> Python package OK"

install-tools:
	@echo "Installing dependencies..."
	@if ! command -v wasm-tools > /dev/null; then cargo install wasm-tools; else echo "wasm-tools already installed"; fi
	@if ! command -v wit-bindgen > /dev/null; then cargo install wit-bindgen-cli; else echo "wit-bindgen already installed"; fi
	@pip install build tomlkit componentize-py
	@echo "Dependencies installed."

link-all:
	@echo "Linking packages locally..."
	@cd packages/npm && npm link
	@echo "  -> NPM package linked. Use 'npm link @vtx/protocol' in your app."
	@cd packages/python && pip install -e .
	@echo "  -> Python package installed in editable mode."

clean:
	@echo "Cleaning up..."
	@rm -rf target/
	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/wit packages/python/vtx_protocol/generated
	@rm -rf packages/npm/*.tgz packages/npm/types packages/npm/wit packages/npm/node_modules
	@rm -rf packages/rust/target packages/rust/wit