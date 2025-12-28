#!/bin/bash
NEW_VERSION=$1

if [ -z "$NEW_VERSION" ]; then
  echo "Usage: ./bump-version.sh 1.2.0"
  exit 1
fi

echo "Bumping version to $NEW_VERSION..."

sed -i '' "s/^version = \".*\"/version = \"$NEW_VERSION\"/" packages/rust/Cargo.toml

tmp=$(mktemp)
jq --arg v "$NEW_VERSION" '.version = $v' packages/npm/package.json > "$tmp" && mv "$tmp" packages/npm/package.json

sed -i '' "s/^version = \".*\"/version = \"$NEW_VERSION\"/" packages/python/pyproject.toml

sed -i '' "s/package vtx:api@.*;/package vtx:api@$NEW_VERSION;/" wit/vtx.wit

echo "Done! Please verify changes and commit."