#!/bin/bash
# Setup script for Memory Bank MCP server
# Installs native dependencies (better-sqlite3) for the bundled MCP server
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MCP_DIR="$SCRIPT_DIR/mcp-server-build"

if [ ! -d "$MCP_DIR/node_modules/better-sqlite3" ]; then
  echo "Installing Memory Bank MCP server dependencies..."
  cd "$MCP_DIR"
  npm install --production 2>&1
  echo "Done."
else
  echo "Memory Bank MCP server dependencies already installed."
fi
