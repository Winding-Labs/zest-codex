---
name: login
description: Use this skill whenever the user wants to connect Codex to Zest, sign in, authenticate, finish setup, or enable Zest tracking for the current workspace.
metadata:
  short-description: Connect Codex to Zest
---

Run the `login` MCP tool.

Respond in this dashboard format:

```md
**Zest: Login**

Status: Authenticated | Pending | Blocked

- Auth: ...
- User: ...
- Workspace: ...
- Sync: ...
- Reason: ...        # Include only when blocked or pending.
- Next step: ...     # Include when browser/device flow or workspace binding is needed.
```

After the tool returns, briefly tell the user whether authentication succeeded and mention any next step the result implies.
