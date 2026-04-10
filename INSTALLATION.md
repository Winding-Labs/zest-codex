# Zest Codex Plugin Installation

## Recommended Install

As long as the official public Plugin Directory is not supported ([docs](https://developers.openai.com/codex/plugins/build#publish-official-public-plugins)) this is the easiest path for most users.

### 1. Run the installer

Either double-click the `install.sh` or go into the release folder and run:

```bash
bash install.sh
```

The installer installs the plugin at personal level for the current user.

What it does for you:

- copies the plugin files
- rewrites the installed `.mcp.json` so the bundled MCP server uses an absolute path
- removes the stale `~/.codex/plugins/cache/zest-alpha/...` cache if it exists
- creates or updates the right marketplace file
- preserves other plugin entries already present in that marketplace
- creates a backup before changing an existing marketplace file

### 2. Restart Codex

Completely quit Codex, then open it again.

This refreshes the local plugin marketplace.

### 3. Install or enable the plugin

After restart, Codex should see the local Zest plugin.

- Codex desktop app: Go to plugins and select the `Zest Alpha` marketplace. Zest plugin should appear - install it.
- Codex CLI - run `/plugins` and install.

If Codex shows plugin installation options, install or enable `Zest`.

### 4. Make sure the local Zest MCP is enabled

Sometimes, after fresh install, the plugin's MCP server isn't enabled. Verify this using `/mcp` - if Zest doesn't appear as enabled - restart Codex. 

## Install Location

As of April 2, 2026, the official Codex docs split local installs into plugin files and marketplace files:

- plugin payload goes into `.codex/plugins`
- marketplace configuration lives in `.agents/plugins/marketplace.json`

### Personal level

Use this when the plugin should be available for your user account across repositories.

- plugin files: `~/.codex/plugins/zest`
- marketplace file: `~/.agents/plugins/marketplace.json`
- marketplace path: `./.codex/plugins/zest`

## First-Time Setup In Codex

After the plugin is visible:

1. ask Codex to log you into Zest
2. follow the login flow in the browser
3. return to Codex

Example prompt:

```text
Log me into Zest
```

## Using The Bundled Skills

The plugin ships with built-in Zest skills so you can trigger common actions from the Codex prompt box.

In Codex, type `$` to open the skill picker. You should see the Zest skills after the plugin is installed and Codex has been restarted.

Available skills in this package:

- `login`
- `logout`
- `status`
- `workspace`
- `sync`
- `privacy`
- `health`

You can use them in two simple ways:

- natural language, for example: `@Zest Log me in`
- explicit skill selection by typing `$` and choosing the matching Zest skill

Example prompts:

```text
Check my Zest status
// or
$Zest:status
// or
@Zest check my status
```

```text
Sync my Codex activity to Zest
// or
$Zest:sync
// or
@Zest sync my activity
```

```text
Explain what the Zest plugin can read and how privacy filtering works
```

If the Zest skills do not appear after installation, fully quit and reopen Codex once more, then verify that the plugin is installed or enabled.

## Troubleshooting

### The MCP is not enabled

Sometimes, after fresh installation, the plugin's MCP server isn't enabled. Verify this using `/mcp` - if Zest doesn't appear as enabled - restart Codex. 

### The plugin does not appear in Codex

Check all of these:

- the plugin files were copied to `~/.codex/plugins/zest`
- `~/.agents/plugins/marketplace.json` exists and includes the Zest entry
- you restarted Codex after installing

If you are reinstalling over an older alpha build, the installer also clears the legacy `~/.codex/plugins/cache/zest-alpha/...` cache to avoid Codex starting a stale copy of the plugin.

### Login opens the wrong website

The package may have been built against the wrong environment. Ask the sender for a newer package.

### Codex says `node` is missing

The plugin runs a local Node-based MCP server. Install Node and then restart Codex.

### I want to install manually instead of using `install.sh`

You can do that, but make sure you keep the plugin files and the marketplace file in the correct personal-install locations.

If you install manually, update the plugin's `.mcp.json` so the `node` argument points to the absolute path of `dist/mcp/server.js`. Leaving it as `./dist/mcp/server.js` can fail when Codex starts the MCP server from the repository working directory instead of the plugin directory.

If you are replacing an older alpha install, also remove `~/.codex/plugins/cache/zest-alpha` before restarting Codex.

## Uninstall

To remove the plugin:

1. delete the installed plugin folder
2. remove the Zest entry from the matching marketplace file
3. restart Codex

## Need Help

When reporting an installation issue, send the person who shared the package:

- your operating system
- whether the plugin folder exists in the target install location
- whether Codex was restarted
- the exact error message, if there is one
