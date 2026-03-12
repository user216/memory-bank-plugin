# Memory Bank — Copilot Agent Plugin

Persistent AI project memory across sessions. Gives GitHub Copilot agents structured documentation, task management, a knowledge graph, and MCP tools.

**Version:** 0.3.0 | [Changelog](CHANGELOG.md) | [License](LICENSE)

## Install

### Option 1: Local path (recommended for private use)

Clone the repo and add to VS Code settings:

```bash
git clone https://github.com/user216/memory-bank-plugin.git
```

```json
// settings.json
"chat.plugins.paths": {
  "/path/to/memory-bank-plugin": true
}
```

### Option 2: Marketplace

Add the repo as a plugin marketplace source:

```json
"chat.plugins.marketplaces": [
  "user216/memory-bank-plugin"
]
```

Then search `@agentPlugins memory-bank` in the Extensions sidebar.

## Setup

The MCP server installs its dependencies automatically on first use. If you prefer to set up manually:

```bash
cd /path/to/memory-bank-plugin
./setup.sh
```

Requires Node.js 20+.

## What's Included

| Component | Description |
|-----------|-------------|
| **Skill** | `managing-memory-bank` — initialize, update, and query the memory bank |
| **Agents** | `memory-planner` (plan mode) + `memory-worker` (act mode) — handoff pair |
| **Prompts** | `memory-init`, `memory-review`, `memory-task`, `memory-update` |
| **Instructions** | Global instructions for MCP-first memory bank usage |
| **Hooks** | Session start/stop context injection + pre-compact preservation |
| **MCP Server** | SQLite + FTS5 search, knowledge graph, task/decision management |

## MCP Tools

Once installed, the following MCP tools become available in Copilot chat:

- `memory_search` — Full-text search across memory bank
- `memory_query` — Structured query by type, status, date
- `memory_recall` — Token-budgeted context retrieval
- `memory_save_context` — Save active context
- `memory_create_task` / `memory_create_decision` — Create items
- `memory_update_status` — Update task/decision status
- `memory_link` / `memory_unlink` / `memory_graph` — Knowledge graph operations
- `memory_schema` — Discover data model

## License

Apache-2.0
