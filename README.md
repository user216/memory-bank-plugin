# Memory Bank — Copilot Agent Plugin

Persistent AI project memory across sessions. Gives GitHub Copilot agents structured documentation, task management, a knowledge graph, and MCP tools.

**Version:** 0.3.0 | [Changelog](CHANGELOG.md) | [License](LICENSE)

---

## Prerequisites

| Requirement | Version | Check |
|-------------|---------|-------|
| VS Code | 1.95+ | `code --version` |
| Node.js | 20+ | `node --version` |
| npm | 10+ | `npm --version` |
| Git | 2.30+ | `git --version` |

**VS Code setting required** (Agent Plugins is a Preview feature):

```json
"chat.plugins.enabled": true
```

---

## Installation

### Method 1: Local Clone (all platforms, recommended)

Best for private use, development, and offline environments.

<details>
<summary><strong>macOS</strong></summary>

```bash
# Clone the plugin
cd ~/Projects  # or wherever you keep repos
git clone https://github.com/user216/memory-bank-plugin.git

# Install MCP server native dependencies
cd memory-bank-plugin
./setup.sh

# Add to VS Code settings (Cmd+Shift+P → "Preferences: Open User Settings (JSON)")
```

Add to `settings.json`:
```json
{
  "chat.plugins.enabled": true,
  "chat.plugins.paths": {
    "/Users/YOUR_USERNAME/Projects/memory-bank-plugin": true
  }
}
```

> **Apple Silicon (M1/M2/M3/M4)**: `better-sqlite3` downloads a prebuilt binary for `darwin-arm64` automatically. If it fails, ensure Xcode Command Line Tools are installed: `xcode-select --install`

</details>

<details>
<summary><strong>Linux (Ubuntu/Debian/Fedora)</strong></summary>

```bash
# Clone the plugin
cd ~/projects
git clone https://github.com/user216/memory-bank-plugin.git

# Install MCP server native dependencies
cd memory-bank-plugin
./setup.sh

# Add to VS Code settings (Ctrl+Shift+P → "Preferences: Open User Settings (JSON)")
```

Add to `settings.json`:
```json
{
  "chat.plugins.enabled": true,
  "chat.plugins.paths": {
    "/home/YOUR_USERNAME/projects/memory-bank-plugin": true
  }
}
```

> **Build tools**: If `better-sqlite3` prebuilt binary isn't available for your platform, it falls back to compiling from source. Install build tools: `sudo apt install build-essential python3` (Debian/Ubuntu) or `sudo dnf install gcc gcc-c++ make python3` (Fedora).

</details>

<details>
<summary><strong>Windows</strong></summary>

**Option A: Git Bash / WSL**

```bash
# Clone the plugin
cd /c/Users/YOUR_USERNAME/Projects   # Git Bash
# or
cd ~/projects                         # WSL

git clone https://github.com/user216/memory-bank-plugin.git

# Install MCP server native dependencies
cd memory-bank-plugin
./setup.sh
```

**Option B: PowerShell**

```powershell
cd C:\Users\YOUR_USERNAME\Projects
git clone https://github.com/user216/memory-bank-plugin.git

cd memory-bank-plugin\mcp-server-build
npm install --production
```

Add to `settings.json`:
```json
{
  "chat.plugins.enabled": true,
  "chat.plugins.paths": {
    "C:\\Users\\YOUR_USERNAME\\Projects\\memory-bank-plugin": true
  }
}
```

> **Windows note**: The `.mcp.json` uses `bash` as the MCP launcher command. If you don't have Git Bash or WSL, create a `start-mcp.cmd` wrapper:
> ```cmd
> @echo off
> cd /d "%~dp0mcp-server-build"
> if not exist node_modules\better-sqlite3 npm install --production --silent
> node index.js %*
> ```
> Then update `.mcp.json` to use `"command": "cmd"` with `"args": ["/c", "./start-mcp.cmd"]`.

</details>

### Method 2: Git Marketplace Source (auto-updates)

Best for staying up to date. VS Code clones the repo automatically and pulls updates.

Add to `settings.json`:

```json
{
  "chat.plugins.enabled": true,
  "chat.plugins.marketplaces": [
    "user216/memory-bank-plugin"
  ]
}
```

Then in VS Code:
1. Open the Extensions sidebar (`Cmd+Shift+X` / `Ctrl+Shift+X`)
2. Type `@agentPlugins` in the search box
3. Find "memory-bank" and click **Install**

**Supported URL formats:**

| Format | Example |
|--------|---------|
| GitHub shorthand | `user216/memory-bank-plugin` |
| HTTPS | `https://github.com/user216/memory-bank-plugin.git` |
| SSH | `git@github.com:user216/memory-bank-plugin.git` |
| Private repos (SSH) | `git@github.com:org/private-plugin.git` |

> **Private repos**: SSH format works with your SSH keys configured in `~/.ssh/`. No token needed.

### Method 3: Part of Monorepo (for contributors)

If you're working on the main `vscode-memory-bank` monorepo:

```bash
git clone --recurse-submodules https://github.com/user216/vscode-memory-bank.git
```

The plugin is at `copilot-plugin/` (Git submodule). Register it:

```json
{
  "chat.plugins.paths": {
    "/path/to/vscode-memory-bank/copilot-plugin": true
  }
}
```

---

## Post-Install Setup

### 1. Verify the plugin is loaded

- Open VS Code
- Go to Chat view (`Cmd+Shift+I` / `Ctrl+Shift+I`)
- Click the gear icon → **Plugins**
- "memory-bank" should appear in the list

### 2. Initialize your project's Memory Bank

In Copilot chat, type:

```
@memory-planner initialize a memory bank for this project
```

Or use the skill directly:

```
/managing-memory-bank initialize
```

This creates the `memory-bank/` directory with template files.

### 3. Verify MCP server

The MCP server starts automatically when the plugin loads. Check the MCP server list:

- `Cmd+Shift+P` / `Ctrl+Shift+P` → "MCP: List Servers"
- `memory-bank` should appear as running

If it shows an error, run the setup script manually:

```bash
cd /path/to/memory-bank-plugin
./setup.sh    # macOS/Linux
# or
cd mcp-server-build && npm install --production   # Windows
```

---

## What's Included

| Component | Files | Description |
|-----------|-------|-------------|
| **Skill** | `skills/managing-memory-bank/SKILL.md` | Initialize, update, and query the memory bank |
| **Agents** | `agents/memory-planner.agent.md` | Plan mode — reads context, develops strategy, never edits code |
| | `agents/memory-worker.agent.md` | Act mode — executes plans, writes code, documents progress |
| **Prompts** | `prompts/memory-init.prompt.md` | Initialize Memory Bank structure |
| | `prompts/memory-review.prompt.md` | Review and summarize full context |
| | `prompts/memory-task.prompt.md` | Create, update, or query tasks |
| | `prompts/memory-update.prompt.md` | Bulk update all Memory Bank files |
| **Instructions** | `instructions/memory-bank.instructions.md` | Global MCP-first rules (applies to all files) |
| **Hooks** | `hooks/memory-hooks.json` | Session start/stop + pre-compact context preservation |
| **MCP Server** | `mcp-server-build/` + `start-mcp.sh` | SQLite + FTS5 search, knowledge graph, 14 tools |

## MCP Tools Reference

| Tool | Description |
|------|-------------|
| `memory_search` | Full-text search across all memory bank content (FTS5) |
| `memory_query` | Structured query by type (core/task/decision), status, date range |
| `memory_recall` | Token-budgeted context retrieval with priority strategies |
| `memory_save_context` | Save current focus, recent changes, and next steps |
| `memory_create_task` | Create a new task with plan steps and subtasks |
| `memory_create_decision` | Create an ADR with context, decision, alternatives, consequences |
| `memory_update_status` | Update task/decision status with progress log |
| `memory_update_decision` | Update ADR content (title, context, decision, alternatives) |
| `memory_import_decisions` | Import ADR files from external directories |
| `memory_link` | Create typed relationships between items (knowledge graph) |
| `memory_unlink` | Remove relationships |
| `memory_update_link` | Change relationship type |
| `memory_graph` | Traverse knowledge graph from a starting item |
| `memory_schema` | Discover data model, item types, status values, relation types |

---

## Troubleshooting

### Plugin not appearing in VS Code

1. Ensure `"chat.plugins.enabled": true` is set in `settings.json`
2. Check the path in `chat.plugins.paths` is absolute and correct
3. Reload VS Code (`Cmd+Shift+P` → "Developer: Reload Window")
4. Check VS Code version is 1.95+

### MCP server won't start

1. Check Node.js version: `node --version` (must be 20+)
2. Run setup manually:
   ```bash
   cd /path/to/memory-bank-plugin/mcp-server-build
   npm install --production
   ```
3. Test the server directly:
   ```bash
   MEMORY_BANK_PATH=/path/to/your/project/memory-bank node mcp-server-build/index.js
   ```
4. Check VS Code Output panel → "Memory Bank MCP" for error messages

### `better-sqlite3` build fails

This native module needs a C++ compiler to build from source if no prebuilt binary is available.

| OS | Install build tools |
|----|---------------------|
| macOS | `xcode-select --install` |
| Ubuntu/Debian | `sudo apt install build-essential python3` |
| Fedora/RHEL | `sudo dnf install gcc gcc-c++ make python3` |
| Windows | Install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) with "Desktop development with C++" workload |

### Hooks not firing

1. Hooks require the agent to be running in a Copilot agent session (not regular chat)
2. Check that `hooks/memory-hooks.json` has correct relative paths
3. Ensure hook scripts are executable: `chmod +x hooks/scripts/*.sh`

---

## Updating

### Local clone

```bash
cd /path/to/memory-bank-plugin
git pull
./setup.sh   # Re-install deps if needed after updates
```

### Marketplace source

Updates are automatic — VS Code pulls the latest from the Git repo.

### Monorepo submodule

```bash
cd /path/to/vscode-memory-bank
git submodule update --remote copilot-plugin
```

---

## Uninstall

### Remove from settings

Remove the plugin entry from `chat.plugins.paths` or `chat.plugins.marketplaces` in `settings.json`.

### Delete local files

```bash
rm -rf /path/to/memory-bank-plugin
```

> **Note**: Uninstalling the plugin does NOT delete your project's `memory-bank/` directory. Your memory bank data is always safe in your project.

---

## License

Apache-2.0
