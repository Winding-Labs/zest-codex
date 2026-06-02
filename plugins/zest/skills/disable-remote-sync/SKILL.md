---
name: disable-remote-sync
description: Use this skill whenever the user wants to turn off remote sync, pause uploads, keep Zest data local, or stop sending queued Codex activity to Zest.
metadata:
  short-description: Disable remote upload
---

Run the `disable_remote_sync` MCP tool.

Respond in this dashboard format:

```md
**Zest: Disable Remote Sync**

Status: Disabled | Warning

- Remote sync: Disabled
- Collection: Enabled
- Queueing: Enabled
- Queue: ...
- Next step: Run `zest:enable-remote-sync` when uploads should resume.
```

Summarize that local collection and queueing remain enabled, but remote upload is disabled until the user enables it again.
