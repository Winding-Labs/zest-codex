---
name: debug
description: Use this skill whenever the user wants to create, collect, generate, or package Zest Codex diagnostics, logs, support bundle, debug bundle, troubleshooting bundle, or says "debug zest".
metadata:
  short-description: Create a local support bundle
---

Run the `debug` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Debug**

Status: Bundle created | Blocked | Warning

- Bundle: ...
- Selected chat: ...
- Redaction: ...
- Upload: Not uploaded
- Reason: ...        # Include only when blocked or degraded.
- Next step: ...     # Include only when there is an action to take.
```

Summarize the generated bundle path, selected chat confidence, and redaction summary. Tell the user the bundle is local and was not uploaded. Do not print raw bundle contents into chat.
