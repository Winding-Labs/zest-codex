# Zest for Codex

Track your Codex sessions in Zest: automatic standups, token and cost
analytics, and a picture of how your team actually works across every AI tool.

This repository is the public marketplace mirror for the Zest Codex plugin. It
carries the built bundle that Codex installs; the source lives in the Zest
monorepo and this tree is regenerated on every release.

## Install

### Codex App

Open Plugins, choose `Add marketplace`, and use:

```text
Source: Winding-Labs/zest-codex
Git ref: main
```

Leave sparse paths empty. This repository is intentionally small, so a full
checkout is the recommended path. Install the `Zest` plugin, then fully restart
Codex.

### Codex CLI

    codex plugin marketplace add Winding-Labs/zest-codex --ref main

Then restart Codex so the skills and the MCP server are reloaded.

A ZIP with `install.sh` is attached to every release as a fallback for
environments that cannot add a marketplace.

Full instructions: https://app.meetzest.com/docs/install/codex

## First run

Ask Codex `Log me into Zest`, follow the browser login, then come back and ask
`Check my Zest status`.

## Skills

| Skill | What it does |
|---|---|
| `login` | Connect Codex to your Zest workspace |
| `logout` | Sign out without losing queued data |
| `status` | Auth, workspace, sync state and health |
| `sync` | Force a sync now |
| `standup` | Generate today's standup |
| `enable-background-sync` | Enable background sync |
| `disable-background-sync` | Disable background sync |
| `enable-remote-sync` | Enable remote upload to Zest |
| `disable-remote-sync` | Disable remote upload (keep capturing locally) |
| `workspace` | View or change workspace binding |
| `privacy` | Inspect privacy filtering |
| `ignore` | Stop tracking a folder |
| `unignore` | Resume tracking a folder |
| `health` | Check Zest plugin health |
| `debug` | Create a local support bundle |
| `cleanup-legacy-alpha` | Remove old Zest Alpha install |

## What it captures

Sessions, messages, tool calls, models, per-turn token usage and context
pressure. Everything is redacted on your machine before it is sent, using
the same privacy pipeline every Zest plugin uses.

## Updating

    codex plugin marketplace upgrade zest

The plugin also checks passively on most Zest MCP tool calls and returns the
same command when a newer version is available.

## Requirements

Node >= 22.13 (the plugin's hooks, MCP server, and daemon run under Node;
Node 20 reached end of life 2026-04-30). This is a breaking floor: Node
20, 21, and 22.0–22.12 fail closed at every Codex entry point after this
update. Upgrade Node before installing.

## Coming from Zest Alpha

Install this marketplace, restart Codex, and if both `Zest` and `Zest Alpha`
still show up, ask Codex `Clean up old Zest Alpha install`.

## License

Proprietary — see LICENSE.md. Third-party components included in this
distribution are listed in THIRD-PARTY-NOTICES.md.

Questions: hi@winding.ai
