---
name: cleanup-legacy-alpha
description: Use this skill whenever the user wants to remove the old Zest Alpha marketplace, clean up a duplicate Zest Alpha entry, or finish migrating from Zest Alpha to the Zest marketplace.
metadata:
  short-description: Remove old Zest Alpha install
---

Run the `cleanup_legacy_alpha` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Cleanup Legacy Alpha**

Status: Cleaned | Already clean | Blocked | Warning

- Removed: ...
- Backups: ...
- Restart: ...
- Reason: ...        # Include only when blocked or degraded.
- Next step: ...     # Include restart guidance when `restartRequired` is true.
```

Summarize what was removed, list any backup paths if present, and tell the user to fully restart Codex when `restartRequired` is true.
