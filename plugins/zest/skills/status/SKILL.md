---
name: status
description: Use this skill whenever the user asks whether Zest is connected, ready, logged in, bound to a workspace, or ready to sync.
metadata:
  short-description: Show auth and sync readiness
---

Run the `status` MCP tool.

Respond in this dashboard format:

```md
**Zest: Status**

Status: Ready | Blocked | Warning

- Version: ...
- Auth: ...
- Workspace: ...
- Sync: ...
- Remote sync: ...
- Background sync: ...
- Queue: ...
- Folder tracking: ...
- Standup: ...
- Logging: ...
- Reason: ...        # Include only when blocked or degraded.
- Next step: ...     # Include only when there is an action to take.
```

Summarize the current plugin version from the `version` field, whether the user is authenticated, whether a workspace is bound, and whether sync is ready. When a workspace is present, mention `workspace.name` first and fall back to `workspace.id` only if the name is unavailable.

Also mention remote sync state, queued payload counts, ignored folder count, and any standup readiness summary when present. If readiness is blocked, name the blocking reason.

If the response includes `logging`, mention whether local diagnostics logging is enabled and the current level. Do not print the log file path unless the user asks for troubleshooting details.
