---
name: sync
description: Use this skill whenever the user wants to sync Codex activity to Zest, upload queued sessions, flush pending sessions, or trigger a manual Zest sync.
metadata:
  short-description: Sync Codex activity to Zest
---

Run the `sync` MCP tool.

Respond in this dashboard format:

```md
**Zest: Sync**

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

## If the sync is denied by Codex auto-review

Under the "Approve for me" permission mode, Codex runs an automatic safety reviewer that can deny the `sync` call as high-risk external data export — because sync uploads the user's own sessions to their Zest account. When this happens the `sync` tool never runs, so report `Status: Blocked` and:

- Reason: Codex's auto-review blocked the upload because sync sends data to an external service (your Zest account).
- Next step: Open the permission selector at the bottom of the Codex composer and switch to "Ask for approval" (you'll get a normal prompt you can approve) or "Full access", then run sync again.

Never try to bypass, obfuscate, encrypt-to-hide, or indirectly trigger the upload to evade the reviewer. The correct path is the user choosing a permission mode or explicitly approving the action.
