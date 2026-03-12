# Changelog

## 0.3.0 (2026-03-12)

Initial release as Copilot Agent Plugin.

### Added
- `managing-memory-bank` skill with templates (projectbrief, task, decision)
- `memory-planner` agent — plan mode (read-only, strategy)
- `memory-worker` agent — act mode (execution, code changes)
- 4 prompt files: `memory-init`, `memory-review`, `memory-task`, `memory-update`
- Global instructions with MCP-first principle
- Session hooks: start (context injection), stop (context persistence), pre-compact (context preservation)
- MCP server bundled with auto-install (`start-mcp.sh`)
- SQLite + FTS5 full-text search, knowledge graph, task/decision management via MCP tools
