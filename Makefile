.PHONY: all check verify-wit verify-bindings check-packages install-tools clean help

all: check

help:
	@echo "Available commands:"
	@echo "  make check           - Run all verification steps"
	@echo "  make verify-wit      - Validate WIT syntax"
	@echo "  make verify-bindings - Test binding generation"
	@echo "  make check-packages  - Verify package structures"
	@echo "  make install-tools   - Install development dependencies"
	@echo "  make clean           - Cleanup artifacts"

check: verify-wit verify-bindings check-packages

verify-wit:
	@echo "[1/3] Validating WIT syntax..."
	@if ! command -v wasm-tools > /dev/null; then echo "Error: wasm-tools not found. Run 'make install-tools'"; exit 1; fi
	@wasm-tools component wit wit/ > /dev/null
	@echo "✅ WIT syntax is valid."

verify-bindings:
	@echo "[2/3] Testing binding generation compatibility..."
	@mkdir -p target/gen-test

	@echo "  -> Testing Rust generator..."
	@wit-bindgen rust wit/ --out-dir target/gen-test/rust

	@echo "  -> Testing C generator..."
	@wit-bindgen c wit/ --out-dir target/gen-test/c

	@echo "✅ Bindings generation successful."

check-packages: check-rust check-npm check-python

check-rust:
	@echo "[3/3] Checking Rust package..."
	@cd packages/rust && cargo check --quiet
	@echo "  -> Rust package OK"

check-npm:
	@echo "[3/3] Checking NPM package..."
	@cd packages/npm && npm pack --dry-run > /dev/null 2>&1
	@echo "  -> NPM package OK"

check-python:
	@echo "[3/3] Checking Python package..."
	@# Simulate build environment
	@mkdir -p packages/python/vtx_protocol/wit
	@cp wit/vtx.wit packages/python/vtx_protocol/wit/
	@cd packages/python && python3 -m build --sdist > /dev/null 2>&1
	@# Cleanup simulation artifacts
	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/wit
	@echo "  -> Python package OK"

install-tools:
	@echo "Installing dependencies..."
	@if ! command -v wasm-tools > /dev/null; then cargo install wasm-tools; else echo "wasm-tools already installed"; fi
	@if ! command -v wit-bindgen > /dev/null; then cargo install wit-bindgen-cli; else echo "wit-bindgen already installed"; fi
	@pip install build

clean:
	@echo "Cleaning up..."
	@rm -rf target/
	@rm -rf packages/python/dist packages/python/*.egg-info packages/python/vtx_protocol/wit
	@rm -rf packages/npm/*.tgz