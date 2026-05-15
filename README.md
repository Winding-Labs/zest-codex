# Zest Codex Plugin

Zest for Codex connects Codex sessions to Zest so AI workflow activity can be collected, synced, and used for team visibility and standups.

This repository is the public Git marketplace mirror for the Zest Codex plugin. It contains the built plugin bundle that Codex installs from the `zest` marketplace.

## Install

### Codex App

Open Plugins, choose `Add marketplace`, and use:

```text
Source: Winding-Labs/zest-codex
Git ref: main
```

Leave sparse paths empty. This repository is intentionally small, so a full checkout is the recommended path.

After adding the marketplace, install or enable the `Zest` plugin, then fully restart Codex.

### Codex CLI

Add the Zest marketplace from your terminal:

```bash
codex plugin marketplace add Winding-Labs/zest-codex --ref main
```

Then restart Codex so the plugin skills and MCP server are reloaded.

## First-Time Setup

Once the plugin is installed, ask Codex:

```text
Log me into Zest
```

Follow the browser login flow, then return to Codex.

To check whether everything is ready:

```text
Check my Zest status
```

## Updating

When a new version is published, update the marketplace from Codex:

```bash
codex plugin marketplace upgrade zest
```

The plugin also performs a passive update check on most Zest MCP tool calls and may return the same upgrade command when a newer version is available.

## Repository Layout

```text
.agents/plugins/marketplace.json  Codex marketplace definition
plugins/zest/                     Built Zest plugin bundle
INSTALLATION.md                   Detailed install and troubleshooting guide
install.sh                        Legacy ZIP fallback installer
package.json                      Published version metadata
```

## For Alpha Users

If you used the previous `Zest Alpha` Codex plugin, install the new `Zest` marketplace from this repository, then restart Codex.

If Codex still shows both `Zest` and `Zest Alpha`, ask Codex:

```text
Clean up old Zest Alpha install
```

This removes the old alpha marketplace/cache entries and keeps the new `Zest` plugin.

## Troubleshooting

See [INSTALLATION.md](./INSTALLATION.md) for detailed install, update, cleanup, and troubleshooting steps.
