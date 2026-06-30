# WP AutoCare Skill

## Purpose
This skill enables the Hermes agent to perform automated WordPress maintenance tasks via the WordPress REST API. It checks for available updates, applies safe updates, and generates a plain-English report.

## Authentication
WordPress Application Passwords are used for authentication (available in WordPress 5.6+). The customer provides:
- `WP_SITE_URL`: The full URL of the WordPress site (e.g., https://example.com)
- `WP_APP_PASSWORD`: The WordPress Application Password in the format `username:app-password`

These are passed as environment variables or via the task context. They are NEVER logged or included in any output.

## Available Actions

### 1. Check for Updates
```bash
# Check available plugin updates
curl -s -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/plugins?status=inactive" \
  -H "Content-Type: application/json"

# Check available core update
curl -s -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/settings" \
  -H "Content-Type: application/json"
```

### 2. List All Plugins with Update Status
```bash
curl -s -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/plugins" \
  -H "Content-Type: application/json" | python3 -c "
import json, sys
plugins = json.load(sys.stdin)
for p in plugins:
    name = p.get('name', 'Unknown')
    version = p.get('version', 'N/A')
    new_version = p.get('new_version', None)
    status = p.get('status', 'unknown')
    if new_version:
        print(f'UPDATE AVAILABLE: {name} {version} -> {new_version}')
    else:
        print(f'UP TO DATE: {name} {version} ({status})')
"
```

### 3. Apply a Plugin Update
```bash
# Update a specific plugin (replace PLUGIN_SLUG with actual slug)
curl -s -X PUT -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/plugins/PLUGIN_SLUG" \
  -H "Content-Type: application/json" \
  -d '{"status": "active"}'
```

### 4. Generate Update Report
After running checks, generate a plain-English report summarizing:
- Total plugins checked
- Updates applied successfully
- Updates skipped (with reason)
- Any errors encountered
- Next scheduled maintenance date

## Safety Rules
- NEVER apply updates to plugins flagged as "must-use" or "drop-in"
- NEVER apply updates if the site is in maintenance mode
- ALWAYS check for known conflict patterns before applying updates
- If a premium plugin shows a license error (HTTP 402), flag it for the stripe-link-cli skill to handle
- NEVER store or log WP_APP_PASSWORD in any output, file, or report

## Integration with Stripe Skills
If a plugin update fails with a license/payment error:
1. Flag the plugin name and error in the report
2. Invoke the `stripe-link-cli` skill with the purchase URL
3. Wait for human approval via Stripe Link mobile app
4. Retry the update after successful payment

## Example Task Prompt
```
Using the WP AutoCare skill, check for all available updates on the WordPress site at $WP_SITE_URL.
Apply all safe updates. Skip any that require license renewal and flag them for stripe-link-cli.
Generate a plain-English report of what was done and email it to the customer.
```
