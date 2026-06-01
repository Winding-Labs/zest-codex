---
name: sync
description: Use this skill whenever the user wants to sync Codex activity to Zest, upload queued sessions, flush pending telemetry, or trigger a manual Zest sync.
metadata:
  short-description: Sync Codex activity to Zest
---

Run the `sync` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Sync**

Status: Synced | Queued | Blocked | Warning

- Phase: ...
- Collected: ...
- Ignored: ...
- Uploaded: ...
- Queue: ...
- Remote sync: ...
- Standup: ...
- Reason: ...        # Include only when blocked or deferred.
- Next step: ...     # Include only when there is an action to take.
```

Summarize whether sync completed or queued work for later. Mention the phase, collected and ignored transcript counts, uploaded counts when present, remote sync deferral when present, and any blocking error type.

If the response includes standup readiness, mention whether enough synced data is ready for manual standup generation.
