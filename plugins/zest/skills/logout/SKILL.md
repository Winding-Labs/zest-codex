---
name: logout
description: Use this skill whenever the user wants to disconnect Zest, sign out, clear local auth, or reset the logged-in session without losing queued data.
metadata:
  short-description: Sign out without losing queued data
---

Run the `logout` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Logout**

Status: Signed out | Warning

- Auth: ...
- Workspace binding: ...
- Queue: ...
- Background sync: ...
- Next step: ...     # Include only when there is an action to take.
```

Summarize that auth was cleared and explicitly mention that workspace binding and queued payload state were preserved when the tool reports that.
