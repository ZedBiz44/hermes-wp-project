# WP AutoCare Skill v3
## Purpose
This skill enables Ruby to perform automated WordPress maintenance tasks via the MCP-WP-Connect plugin on the customer's WordPress site. It reads site content, checks for available updates, applies safe updates, and generates a plain-English maintenance report.

## Important: How This Works (Hermes vs OpenClaw)
The MCP-WP-Connect plugin uses a **simplified JSON-RPC 2.0 protocol** (not the full MCP handshake). Hermes's built-in MCP client expects the full MCP protocol (`initialize` → `initialized` → `tools/list`), which the plugin does not support.

**You MUST use direct `curl` calls via your terminal tool** -- do NOT attempt to use the MCP client or look for WP tools in your toolset. They will not appear there. Use the bash commands below instead.

## Credentials (Environment Variables)
The following environment variables are pre-loaded in your container:
- `WP_MCP_ENDPOINT` -- The JSON-RPC endpoint (e.g., `https://deals7.com/wp-json/mcp/v1/http`)
- `WP_MCP_BEARER_TOKEN` -- Bearer token for authentication
- `WP_SITE_URL` -- Base URL of the WordPress site

**Never log, print, or include these values in any output or report.**

## Step 1: List Available Tools
Always start by listing available tools to confirm connection and see what is enabled for this token:

```bash
curl -s -X POST "$WP_MCP_ENDPOINT" \
  -H "Authorization: Bearer $WP_MCP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | python3 -c "import json,sys; d=json.load(sys.stdin); [print(t['name'],'-',t.get('description','')) for t in d['result']['tools']]"
```

## Step 2: Call Any Tool
Use `tools/call` with the tool name and arguments:

```bash
# Read the 5 most recent published posts
curl -s -X POST "$WP_MCP_ENDPOINT" \
  -H "Authorization: Bearer $WP_MCP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/call",
    "params": {
      "name": "wp_posts_read",
      "arguments": {"limit": 5, "status": "publish"}
    }
  }' | python3 -c "import json,sys; d=json.load(sys.stdin); print(json.dumps(d['result'], indent=2))"
```

```bash
# Read all pages
curl -s -X POST "$WP_MCP_ENDPOINT" \
  -H "Authorization: Bearer $WP_MCP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "wp_pages_read",
      "arguments": {"limit": 20}
    }
  }' | python3 -c "import json,sys; d=json.load(sys.stdin); print(json.dumps(d['result'], indent=2))"
```

```bash
# Create a new post (requires write token)
curl -s -X POST "$WP_MCP_ENDPOINT" \
  -H "Authorization: Bearer $WP_MCP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "tools/call",
    "params": {
      "name": "wp_posts_create",
      "arguments": {
        "title": "My New Post",
        "content": "Post content here.",
        "status": "draft"
      }
    }
  }' | python3 -c "import json,sys; d=json.load(sys.stdin); print(json.dumps(d['result'], indent=2))"
```

## Available Tools (Standard Set -- 24 total)
| Category | Tools |
|---|---|
| Posts | `wp_posts_create`, `wp_posts_read`, `wp_posts_update`, `wp_posts_delete` |
| Pages | `wp_pages_create`, `wp_pages_read`, `wp_pages_update`, `wp_pages_delete` |
| Media | `wp_media_create`, `wp_media_read`, `wp_media_update`, `wp_media_delete` |
| Users | `wp_users_create`, `wp_users_read`, `wp_users_update`, `wp_users_delete` |
| Comments | `wp_comments_create`, `wp_comments_read`, `wp_comments_update`, `wp_comments_delete` |
| Taxonomies | `wp_taxonomies_create`, `wp_taxonomies_read`, `wp_taxonomies_update`, `wp_taxonomies_delete` |

Write tools (`_create`, `_update`, `_delete`) only work if the token has write permissions. Always call `tools/list` first to confirm which tools are enabled for the current token.

## WordPress Plugin Update Check (WP REST API)
Plugin update checking uses the standard WP REST API with Application Password credentials (stored as `WP_APP_USER` and `WP_APP_PASSWORD` if configured):

```bash
# List all plugins and update status
curl -s -u "$WP_APP_USER:$WP_APP_PASSWORD" \
  "$WP_SITE_URL/wp-json/wp/v2/plugins" \
  -H "Content-Type: application/json" \
  | python3 -c "import json,sys; plugins=json.load(sys.stdin); [print(p['plugin'], p.get('version','?'), '-> UPDATE:', p.get('new_version','up to date')) for p in plugins]"
```

## Maintenance Report Format
After completing checks, generate a report in this format:

```
WP AutoCare Report -- [Site URL]
Date: [Date]

UPDATES APPLIED:
- [Plugin Name]: [old version] -> [new version]

UPDATES SKIPPED (conflict risk):
- [Plugin Name]: [reason]

UP TO DATE:
- [count] plugins are current

CONTENT SUMMARY:
- Posts: [count] published
- Pages: [count] published

NEXT SCHEDULED CHECK: [date]
```

## Error Handling
- If `curl` returns an error object (`"error"` key in response), log the error code and message
- If the endpoint returns 401, the bearer token may have been revoked -- notify Jack immediately
- If the endpoint returns 404, the plugin may have been deactivated on the WP site

## Version History
- v1: Initial skill (MCP client approach -- broken with Hermes)
- v2: Added env var injection (MCP client still broken)
- v3: Switched to direct curl/JSON-RPC 2.0 calls -- bypasses Hermes MCP client entirely (2026-07-01)
