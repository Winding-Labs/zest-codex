# Zest Codex Plugin Installation

## What You Received

You should have received a zip file that contains:

- `install.sh`
- `marketplace.json`
- a `zest/` folder

You do not need to build anything.

## Recommended Install

This is the easiest path for most users.

### 1. Open the release folder

Inside the release folder, you should see:

```text
install.sh
marketplace.json
zest/
INSTALLATION.md
```

### 2. Run the installer

From Terminal, go into the release folder and run:

```bash
bash install.sh
```

The installer is interactive and lets you choose:

- `Workspace level`
- `Personal level`

What it does for you:

- copies the plugin files
- rewrites the installed `.mcp.json` so the bundled MCP server uses an absolute path
- removes the stale `~/.codex/plugins/cache/zest-alpha/...` cache if it exists
- creates or updates the right marketplace file
- preserves other plugin entries already present in that marketplace
- creates a backup before changing an existing marketplace file

### 3. Restart Codex

Completely quit Codex, then open it again.

This refreshes the local plugin marketplace.

### 4. Install or enable the plugin

After restart, Codex should see the local Zest plugin.

If Codex shows plugin installation options, install or enable `Zest`.

## Install Locations

As of April 2, 2026, the official Codex docs split local installs into plugin files and marketplace files:

- plugin payload goes into `.codex/plugins`
- marketplace configuration lives in `.agents/plugins/marketplace.json`

The installer supports these two install modes.

### Workspace level

Use this when the plugin should be available only in one repository.

- plugin files: `$REPO_ROOT/plugins/zest`
- marketplace file: `$REPO_ROOT/.agents/plugins/marketplace.json`
- marketplace path: `./plugins/zest`

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

## If You Already Use Other Local Plugins

The installer does not replace your whole marketplace file. It updates or inserts the `zest` entry and keeps other entries intact.

If you also use the repository-linked development plugin, it should appear separately as `Zestdev` / `zestdev`. The release installer intentionally leaves that local dev plugin alone so you can test both on one machine.

If you prefer to edit the marketplace file manually, add this plugin entry into your existing `plugins` array.

For workspace installs use:

```json
{
  "name": "zest",
  "source": {
    "source": "local",
    "path": "./plugins/zest"
  },
  "policy": {
    "installation": "AVAILABLE",
    "authentication": "ON_INSTALL"
  },
  "category": "Productivity"
}
```

For personal installs use:

```json
{
  "name": "zest",
  "source": {
    "source": "local",
    "path": "./.codex/plugins/zest"
  },
  "policy": {
    "installation": "AVAILABLE",
    "authentication": "ON_INSTALL"
  },
  "category": "Productivity"
}
```

## Troubleshooting

### The plugin does not appear in Codex

Check all of these:

- the plugin files were copied to the correct location for your selected install scope
- the matching marketplace file exists
- you restarted Codex after installing

If you are reinstalling over an older alpha build, the installer also clears the legacy `~/.codex/plugins/cache/zest-alpha/...` cache to avoid Codex starting a stale copy of the plugin.

### Login opens the wrong website

The package may have been built against the wrong environment. Ask the sender for a newer package.

### Codex says `node` is missing

The plugin runs a local Node-based MCP server. Install Node and then restart Codex.

### I want to install manually instead of using `install.sh`

You can do that, but make sure you keep the plugin files and the marketplace file in the correct locations for either workspace or personal install.

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
