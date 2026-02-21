#!/usr/bin/env bash
# Assemble _docs/ from package sources, then build with Zensical.
# All original files stay in place — only copies land in _docs/.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/_docs"

rm -rf "$DOCS"
mkdir -p \
    "$DOCS/stylesheets" \
    "$DOCS/coding-agent/images" \
    "$DOCS/libraries" \
    "$DOCS/mom" \
    "$DOCS/pods"

# ── Hand-written docs assets ──
cp "$ROOT/docs/index.md"                    "$DOCS/index.md"
cp "$ROOT/docs/stylesheets/extra.css"       "$DOCS/stylesheets/extra.css"

# ── Root-level docs ──
cp "$ROOT/CONTRIBUTING.md"                  "$DOCS/contributing.md"

# ── Coding Agent ──
# Overview is the README — fix image paths (docs/images/ → images/) since
# the README moves from packages/coding-agent/ into coding-agent/ alongside
# the docs it used to reference via docs/images/.
sed 's|src="docs/images/|src="../images/|g' \
    "$ROOT/packages/coding-agent/README.md" > "$DOCS/coding-agent/overview.md"
cp "$ROOT/packages/coding-agent/docs/"*.md  "$DOCS/coding-agent/"
cp -r "$ROOT/packages/coding-agent/docs/images/"* "$DOCS/coding-agent/images/"

# ── Libraries (README-only packages) ──
cp "$ROOT/packages/ai/README.md"            "$DOCS/libraries/ai.md"
cp "$ROOT/packages/agent/README.md"         "$DOCS/libraries/agent.md"
cp "$ROOT/packages/tui/README.md"           "$DOCS/libraries/tui.md"
cp "$ROOT/packages/web-ui/README.md"        "$DOCS/libraries/web-ui.md"

# ── Mom ──
cp "$ROOT/packages/mom/README.md"           "$DOCS/mom/overview.md"
cp "$ROOT/packages/mom/docs/"*.md           "$DOCS/mom/"

# ── Pods ──
cp "$ROOT/packages/pods/README.md"          "$DOCS/pods/overview.md"
cp "$ROOT/packages/pods/docs/"*.md          "$DOCS/pods/"

echo "Assembled $(find "$DOCS" -name '*.md' | wc -l | tr -d ' ') docs into _docs/"
