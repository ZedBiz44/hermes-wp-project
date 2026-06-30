# WP AutoCare Skill

## Purpose

This skill enables the Hermes agent to perform automated WordPress maintenance tasks via the MCP-WP-Connect plugin. It reads site content, checks for available updates via the WordPress REST API, applies safe updates, and generates a plain-English maintenance report.

## Connection Method

This skill uses the **MCP-WP-Connect plugin** (ZedBiz44/MCP-WP-Connect-Plugin) installed on the customer's WordPress site. Authentication is via a named Bearer token.

The following environment variables are available in the container:

- `WP_MCP_ENDPOINT`: The MCP endpoint URL (e.g., `https://deals7.com/wp-json/mcp/v1/http`)
- `WP_MCP_BEARER_TOKEN`: The Bearer token for authentication
- `WP_SITE_URL`: The base URL of the WordPress site

These are NEVER logged or included in any output.

## How to Call the MCP Endpoint

All calls use JSON-RPC 2.0 over HTTP POST:

```bash
curl -s -X POST "$WP_MCP_ENDPOINT" \
  -H "Authorization: Bearer $WP_MCP_BEARER_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

## Available Tools (via MCP-WP-Connect)

Call `tools/list` to get the current list. Standard tools include:

- `wp_posts_read` — Read posts
- `wp_pages_read` — Read pages
- `wp_users_read` — Read users
- `wp_media_read` — Read media
- `wp_comments_read` — Read comments
- `wp_taxonomies_read` — Read taxonomies

Write tools (when read-only mode is disabled):
- `wp_posts_create`, `wp_posts_update`, `wp_posts_delete`
- `wp_pages_create`, `wp_pages_update`, `wp_pages_delete`

## Calling a Tool

```bash
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
  }'
```

## WordPress Update Check (via WP REST API)

For plugin update checking, use the standard WP REST API in addition to MCP-WP-Connect. The update check requires admin authentication via Application Password:

```bash
# List all plugins and their update status
curl -s -u "$WP_APP_USER:$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/plugins" \
  -H "Content-Type: application/json"
```

Look for plugins where `new_version` is not null — those have updates available.

## Maintenance Report Format

After running the update check, generate a report in this format:

```
WP AutoCare Report — [Site URL]
Date: [Date]

UPDATES APPLIED:
- [Plugin Name]: [old version] → [new version]

UPDATES SKIPPED (conflict risk):
- [Plugin Name]: [reason]

UP TO DATE:
- [count] plugins are current

NEXT SCHEDULED CHECK: [date]
```

## Security Notes

- Bearer tokens are hashed server-side — the plugin never stores the raw token
- Each token is named and scoped (read vs read/write, per category)
- Tokens can be revoked from the WP Dashboard > Settings > MCP-WP-Connect at any time
- Never include token values in logs, reports, or any output
