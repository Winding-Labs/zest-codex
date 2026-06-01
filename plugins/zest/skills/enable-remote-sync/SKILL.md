---
name: enable-remote-sync
description: Use this skill whenever the user wants to turn remote sync back on, resume uploads, or send queued Codex activity to Zest again.
metadata:
  short-description: Enable remote upload
---

Run the `enable_remote_sync` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Enable Remote Sync**

Status: Enabled | Warning

- Remote sync: Enabled
- Queue: ...
- Uploads: Ready for the next manual or background sync
- Next step: Run `zestdev:sync` to upload queued activity now.
```

Summarize that remote upload is enabled again and queued Codex activity can be uploaded by the next manual sync.
