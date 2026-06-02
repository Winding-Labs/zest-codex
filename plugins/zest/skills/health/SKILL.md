---
name: health
description: Use this skill whenever the user wants to check whether the Zest plugin is installed, reachable, up, healthy, or responding at all.
metadata:
  short-description: Check Zest plugin health
---

Run the `health` MCP tool.

Respond in this dashboard format:

```md
**Zest: Health**

Status: Healthy | Blocked | Warning

- Service: ...
- Version: ...
- Update: ...
- Reason: ...        # Include only when unhealthy or degraded.
- Next step: ...     # Include only when there is an action to take.
```

Summarize the service status and version. If update metadata is present, mention whether an update is available.
