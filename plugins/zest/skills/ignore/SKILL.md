---
name: ignore
description: Use this skill whenever the user wants Zest to ignore, exclude, mute, or stop collecting Codex activity for the current folder or a specific folder.
metadata:
  short-description: Ignore a Codex folder
---

Run the `ignore` MCP tool.

If the user gave a folder path, pass it as `folderPath`. Otherwise let the tool resolve the active Codex folder.

Respond in this dashboard format:

```md
**Zest: Ignore**

Status: Ignored | Already ignored | Blocked

- Folder: ...
- Ignored folders: ...
- Collection: ...
- Reason: ...        # Include only when blocked.
- Next step: ...     # Include only when there is an action to take.
```

Summarize which folder is now ignored and mention the current ignored folder count.
