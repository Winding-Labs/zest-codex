---
name: disable-background-sync
description: Use this skill whenever the user wants Zest Codex background sync, automatic sync, or daemon-based syncing turned off.
metadata:
  short-description: Disable background sync
---

Run the `disable_background_sync` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Disable Background Sync**

Status: Disabled | Warning

- Background sync: Disabled
- Daemon: ...
- Manual sync: Available
- Next step: Run `zestdev:enable-background-sync` when automatic sync should resume.
```

Summarize that automatic background sync is disabled until the user enables it again.
