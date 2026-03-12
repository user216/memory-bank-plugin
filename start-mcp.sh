#!/bin/bash
# MCP server launcher — installs deps on first run, then starts the server
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MCP_DIR="$SCRIPT_DIR/mcp-server-build"

if [ ! -d "$MCP_DIR/node_modules/better-sqlite3" ]; then
  cd "$MCP_DIR" && npm install --production --silent 2>/dev/null
fi

exec node "$MCP_DIR/index.js" "$@"
