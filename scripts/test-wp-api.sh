#!/bin/bash
# WP AutoCare — WordPress REST API Connection Test
# Usage: WP_SITE_URL=https://example.com WP_APP_PASSWORD="username:app-password" bash test-wp-api.sh

set -e

if [ -z "$WP_SITE_URL" ] || [ -z "$WP_APP_PASSWORD" ]; then
  echo "ERROR: Set WP_SITE_URL and WP_APP_PASSWORD environment variables first."
  echo "Example: WP_SITE_URL=https://example.com WP_APP_PASSWORD='admin:xxxx xxxx xxxx' bash test-wp-api.sh"
  exit 1
fi

echo "=== WP AutoCare REST API Test ==="
echo "Site: $WP_SITE_URL"
echo ""

echo "[1/4] Testing basic WP REST API connectivity..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$WP_SITE_URL/wp-json/wp/v2")
if [ "$STATUS" = "200" ]; then
  echo "  PASS: REST API accessible (HTTP $STATUS)"
else
  echo "  FAIL: REST API returned HTTP $STATUS"
  exit 1
fi

echo "[2/4] Testing Application Password authentication..."
AUTH_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/users/me")
if [ "$AUTH_STATUS" = "200" ]; then
  echo "  PASS: Authentication successful (HTTP $AUTH_STATUS)"
else
  echo "  FAIL: Authentication failed (HTTP $AUTH_STATUS)"
  exit 1
fi

echo "[3/4] Fetching plugin list..."
PLUGINS=$(curl -s -u "$WP_APP_PASSWORD" "$WP_SITE_URL/wp-json/wp/v2/plugins" 2>/dev/null)
PLUGIN_COUNT=$(echo "$PLUGINS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(len(d))" 2>/dev/null || echo "0")
echo "  Found $PLUGIN_COUNT plugins"

echo "[4/4] Checking for available updates..."
echo "$PLUGINS" | python3 -c "
import json, sys
plugins = json.load(sys.stdin)
updates = [p for p in plugins if p.get('new_version')]
current = [p for p in plugins if not p.get('new_version')]
print(f'  Updates available: {len(updates)}')
for p in updates:
    print(f'    - {p[\"name\"]}: {p[\"version\"]} -> {p[\"new_version\"]}')
print(f'  Up to date: {len(current)}')
" 2>/dev/null || echo "  Could not parse plugin update data"

echo ""
echo "=== Test Complete — Hermes WP AutoCare agent is ready ==="
