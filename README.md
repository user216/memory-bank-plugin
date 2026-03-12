# Memory Bank — Copilot Agent Plugin

Persistent AI project memory across sessions. Gives GitHub Copilot agents structured documentation, task management, a knowledge graph, and MCP tools.

## Install

In VS Code, open the Extensions sidebar and search `@agentPlugins memory-bank`, or add the plugin marketplace manually:

```json
// settings.json
"chat.plugins.marketplaces": [
  "user216/memory-bank-plugin"
]
```

Or install locally:

```json
"chat.plugins.paths": {
  "/path/to/memory-bank-plugin": true
}
```

## What's Included

| Component | Description |
|-----------|-------------|
| **Skill** | `managing-memory-bank` — initialize, update, and query the memory bank |
| **Agents** | `memory-planner` (plan mode) + `memory-worker` (act mode) — handoff pair |
| **Prompts** | `memory-init`, `memory-review`, `memory-task`, `memory-update` |
| **Instructions** | Global instructions for MCP-first memory bank usage |
| **Hooks** | Session start/stop context injection + pre-compact preservation |
| **MCP Server** | `vscode-memory-bank-mcp` — SQLite + FTS5 search, knowledge graph, task/decision management |

## MCP Server

The MCP server runs via `npx`:

```bash
npx -y vscode-memory-bank-mcp@latest
```

Set `MEMORY_BANK_PATH` to your project's `memory-bank/` directory.

## License

Apache-2.0
