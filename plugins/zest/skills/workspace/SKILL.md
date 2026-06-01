---
name: workspace
description: Use this skill whenever the user wants to see which Zest workspace is active, bind Codex to a workspace, change the workspace, or fix an unbound workspace.
metadata:
  short-description: View or change workspace binding
---

Run the `workspace` MCP tool.

If the user gave a workspace id, pass it as `workspaceId`.

Respond in this dashboard format:

```md
**Zestdev: Workspace**

Status: Bound | Not bound | Updated | Blocked

- Workspace: ...
- Binding: ...
- Sync: ...
- Reason: ...        # Include only when blocked or unbound.
- Next step: ...     # Include only when there is an action to take.
```

Summarize whether the workspace is bound and, when available, include the active workspace name first and fall back to the workspace id only if the name is unavailable. Mention whether the binding was updated.
