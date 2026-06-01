---
name: privacy
description: Use this skill whenever the user asks what Zest can read, how privacy filtering works, what gets redacted, or whether secrets are exposed before upload.
metadata:
  short-description: Inspect privacy filtering
---

Run the `privacy` MCP tool.

If the user asks to change privacy settings, pass the requested fields:

- `approach` for `detection`, `encryption`, or `hybrid`
- `aggressiveMode` for stricter local filtering
- `enableGitignore` or `enableZestRules` for source-specific exclusions
- `addCustomExclusionPattern` or `removeCustomExclusionPattern` for custom glob rules

Respond in this dashboard format:

```md
**Zestdev: Privacy**

Status: Active | Updated | Warning

- Mode: ...
- Aggressive filtering: ...
- Gitignore rules: ...
- Zest rules: ...
- Custom exclusions: ...
- Redaction: ...
- Next step: ...     # Include only when there is an action to take.
```

Summarize the active privacy mode, what sources are allowed, and whether redaction happens before queueing and upload.
