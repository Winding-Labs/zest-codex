# Zest Codex Plugin Installation

## Recommended Install

Install Zest by adding the Zest Git marketplace in Codex.

### 1. Add the marketplace from Codex App

Open Codex Plugins, choose `Add marketplace`, and use:

```text
Source: Winding-Labs/zest-codex
Git ref: main
```

Leave sparse paths empty. The Zest marketplace repository is intentionally small, so a full checkout is the simplest and most reliable default.

### 2. Or add the marketplace from Codex CLI

From your terminal, run:

```bash
codex plugin marketplace add Winding-Labs/zest-codex --ref main
```

### 3. Install Zest

After the marketplace is added, Codex should show the `Zest` marketplace and the `Zest` plugin.

Open the `Zest` marketplace in Codex, then install `Zest` by clicking the `+` button. Adding the marketplace only makes the plugin available; it does not install the plugin automatically.

### 4. Enable Plugin Hooks

Enable Codex plugin hooks so Zest can refresh auth and run automatic update checks when a new Codex session starts:

```bash
codex features enable plugin_hooks
```

Without `plugin_hooks`, the Zest MCP server and skills can still work, but the bundled `SessionStart` and `UserPromptSubmit` hooks will not run.

### 5. Restart Codex

Completely quit Codex, then open it again.

This refreshes plugin skills, the local MCP server registration, and activates plugin hooks.

### 6. Make sure the local Zest MCP is enabled

Use `/mcp` and confirm that Zest appears as enabled. If it does not appear, restart Codex once more.

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

- `cleanup-legacy-alpha`
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

## Remove Old Zest Alpha

If you migrated from an older `Zest Alpha` install and still see both `Zest` and `Zest Alpha` in Codex, ask Zest to clean up the old install:

```text
Clean up old Zest Alpha install
```

This runs the `cleanup_legacy_alpha` MCP tool. It removes only known legacy Zest Alpha artifacts, creates backups before editing Codex config files, and reports whether a full Codex restart is required.

## Updating

Use Codex marketplace upgrade for the `zest` marketplace when a new version is published.

The plugin also performs a passive best-effort update check before each MCP tool call except `sync`. If a newer version is available, tool responses may include an `update` object with `available`, `latestVersion`, `downloadUrl`, `checkedAt`, `upgradeCommand`, and `instructions`.

Installed production builds also try a guarded automatic upgrade on Codex `SessionStart`. When the
same update check reports a newer version, the hook runs:

```bash
codex plugin marketplace upgrade zest
```

Automatic upgrade attempts are best-effort, throttled to once every 24 hours, protected by a local
lock, and never block Codex startup if the command fails. To disable the automatic attempt, set:

```bash
ZEST_CODEX_AUTOUPDATE_DISABLED=1
```

When `available` is `true`, update Zest with:

```bash
codex plugin marketplace upgrade zest
```

If Codex appears to be using a stale production plugin bundle, clear the production cache and restart
Codex. This also clears Zest's local update-check cache so the next start does not wait for the
update TTL:

```bash
./clear-production-cache.sh
```

To preview the cache entries without removing them:

```bash
./clear-production-cache.sh --dry-run
```

## Optional Sparse Checkout

Sparse paths are optional. They tell Codex to fetch only specific paths from the Git repository.

Because `Winding-Labs/zest-codex` is a small marketplace repository, leave sparse paths empty unless you are debugging checkout behavior. If needed, these paths are enough:

```text
.agents/plugins
plugins/zest
package.json
INSTALLATION.md
```

## Legacy ZIP Fallback

For one release after marketplace-first distribution ships, Zest still publishes a ZIP fallback.

Use this only when the Git marketplace flow is unavailable, for example:

- your Codex build does not support `Add marketplace`
- Git access is blocked in your environment
- support asks you to verify the legacy path

From the unzipped release folder, run:

```bash
bash install.sh
```

The legacy installer installs the plugin at personal level for the current user.

What it does:

- copies the plugin files
- rewrites the installed `.mcp.json` so the bundled MCP server uses an absolute path
- removes stale `~/.codex/plugins/cache/zest-alpha/...` cache from older prerelease installs if it exists
- creates or updates the right marketplace file
- preserves other plugin entries already present in that marketplace
- creates a backup before changing an existing marketplace file

After running the legacy installer, restart Codex and install or enable `Zest` from the `Zest` marketplace.

## Troubleshooting

### The MCP is not enabled

Use `/mcp` and confirm that Zest appears as enabled. If Zest does not appear, restart Codex.

### The plugin does not appear in Codex

Check all of these:

- the `Zest` marketplace was added successfully
- `Zest` is installed or enabled from that marketplace
- you restarted Codex after installing

If you used the legacy ZIP fallback, also check:

- the plugin files were copied to `~/.codex/plugins/zest`
- `~/.agents/plugins/marketplace.json` exists and includes the Zest entry

### Login opens the wrong website

The package may have been built against the wrong environment. Ask the sender for a newer package.

### Codex says `node` is missing

The plugin runs a local Node-based MCP server. Install Node and then restart Codex.

## Uninstall

For marketplace installs:

1. remove or disable the `Zest` plugin in Codex
2. remove the `zest` marketplace if you no longer need it
3. restart Codex

For legacy ZIP installs:

1. delete the installed plugin folder
2. remove the Zest entry from the matching marketplace file
3. restart Codex

## Need Help

When reporting an installation issue, send the person who shared the package:

- your operating system
- whether you used Git marketplace install or ZIP fallback
- whether Codex was restarted
- the exact error message, if there is one
