# Manus Setup Log — WP AutoCare by Hermes
Date: 2026-06-30
Agent: Manus
Status: Active

## What Was Completed Today

### GHL Funnel — All 7 Pages Live

All funnel pages are built and live on zednow.com. The VA built and styled them based on the WP AutoCare brief.

| Page | URL | Status |
|---|---|---|
| Sales Page | https://zednow.com/wp-autocare-hermes | Live |
| Checkout | https://zednow.com/wp-autocare-hermes-checkout-page | Live |
| OTO 1 | https://zednow.com/wp-autocare-hermes-oto1-page | Live |
| Onboarding Form | https://zednow.com/wp-autocare-onboarding-form-page | Live |
| Thank You | https://zednow.com/wp-autocare-hermes-thank-you-page | Live |
| OTO 2 | https://zednow.com/wp-autocare-hermes-oto2-page | Live |
| OTO 2 Thank You | https://zednow.com/wp-autocare-hermes-oto2-thank-you | Live |

### GHL Workflow — Triggers Fixed

The VA resolved the broken Inbound Webhook trigger. The workflow now has three triggers:
- Order Submitted (Global product ID: 6a4391da9b1d...)
- Order Form Submission (WP AutoCare Premium Checkout page in funnel)
- Form Submitted (WP AutoCare Onboarding Form)

Workflow steps confirmed: Add onboarding tags → Email 1 (Welcome + What Happens Next)

### GHL Email Templates — Created via MCP

Five email templates created in GHL for the post-purchase sequence:

| Email | Template Name | GHL Template ID |
|---|---|---|
| Email 2 | WP AutoCare Email 2 - Onboarding Nudge | 6a444501756e264965448602 |
| Email 3 | WP AutoCare Email 3 - Trust Building | 6a44450575d8f1909177788d |
| Email 4 | WP AutoCare Email 4 - First Report & OTO2 | 6a44450a1255b14bc8e57cc5 |
| Email 5 | WP AutoCare Email 5 - Check-in | 6a4445103ecc2fc8031de29b |
| Email 6 | WP AutoCare Email 6 - Monthly Summary | 6a44451405a065f5dee3876e |

These need to be wired into the workflow with wait timers (VA task).

### Stripe Integration

Stripe is connected to GHL in both live and test mode (confirmed via Payments > Integrations).
Three GHL products created: WP AutoCare Monthly ($50), OTO 1 Second Site ($30), OTO 2 Priority ($25).
New Stripe restricted key created in ZedBiz-ZedNow account (AI agent / Full Core permissions).

### Hermes Agent — Ruby VPS3

All configuration changes made directly on the server at 2.25.210.154.

| Item | Before | After |
|---|---|---|
| Model | grok-4.3 (xai-oauth) | nvidia/nemotron-3-ultra-550b-a55b (nous) |
| stripe-link-cli | Not installed | Installed (SAFE) |
| mpp-agent | Not installed | Installed (SAFE) |
| stripe-projects | Not installed | Installed (SAFE) |
| wp-autocare-skill | Not present | Deployed to /opt/hermes-ruby/skills/ |
| STRIPE_SECRET_KEY | Not set | Confirmed live in container env |
| STRIPE_API_KEY | Not set | Confirmed live in container env |

Container was recreated (not just restarted) to inject the Stripe env vars properly. Container ID: 319f6926d405.

Config backup saved on server as: `/opt/hermes-ruby/config.yaml.bak.hackathon-20260630T...`

## Outstanding Items

### Must-Have for Demo (Blocking)

- [ ] **WP REST API live test** — Need a WordPress site URL and Application Password from Jack. This is the core demo proof point.
- [ ] **Record demo video** — 1-3 minutes showing the full loop: funnel → purchase → GHL contact created → Hermes runs WP update → report generated.
- [ ] **Submit** — Tweet @NousResearch @NVIDIAAI @stripe + Discord submissions channel + Typeform.

### Should-Have (VA Tasks)

- [ ] Wire emails 2-6 into GHL workflow with wait timers (1d, 2d, 4d, 7d, 16d after Email 1)
- [ ] Publish the GHL workflow (currently in draft)
- [ ] Fix Thank You page placeholders: support email address + Stripe Customer Portal URL

### Nice-to-Have

- [ ] Z-Knowledge Dashboard (customer record, subscription status, job history) — mentioned in Cody's background doc
- [ ] NemoClaw safety runtime configuration for the demo
- [ ] Stripe webhook endpoint for real-time subscription status sync

## Key Credentials (Do Not Commit Plaintext)

All sensitive credentials are stored as environment variables in the hermes-ruby Docker container on Ruby VPS3. The Stripe key used is a restricted key (`rk_live_...`) with Full Core permissions, created specifically for Hermes in the ZedBiz-ZedNow Stripe account.

WordPress Application Passwords for customer sites will be stored in GHL contact custom fields, not in this repo.
