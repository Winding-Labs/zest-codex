---
name: unignore
description: Use this skill whenever the user wants Zest to stop ignoring, re-include, unmute, or resume collecting Codex activity for the current folder or a specific folder.
metadata:
  short-description: Unignore a Codex folder
---

Run the `unignore` MCP tool.

If the user gave a folder path, pass it as `folderPath`. Otherwise let the tool resolve the active Codex folder.

Respond in this dashboard format:

```md
**Zestdev: Unignore**

Status: Unignored | Not ignored | Blocked

- Folder: ...
- Ignored folders: ...
- Collection: ...
- Reason: ...        # Include only when blocked.
- Next step: ...     # Include only when there is an action to take.
```

Summarize which folder is no longer ignored and mention the current ignored folder count.
