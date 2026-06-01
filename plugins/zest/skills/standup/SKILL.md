---
name: standup
description: Use this skill whenever the user wants to generate, refresh, create, or open a Zest standup from Codex activity.
metadata:
  short-description: Generate a Zest standup
---

Run the `standup` MCP tool.

Respond in this dashboard format:

```md
**Zestdev: Standup**

Status: Generated | Running | No new data | Blocked

- Result: ...
- New data: ...
- Standup: ...
- URL: ...
- Reason: ...        # Include only when blocked or no data.
- Next step: ...     # Include only when there is an action to take.
```

Summarize whether standup generation started, completed, was already running, or had no new data. If the result includes a URL, include it as the place to view the standup.
