# Notion Project Page Review

Date: 2026-06-30
Agent: Cody
Status: Review Logged

## Reviewed Page

- Notion project hub: https://app.notion.com/p/38fa3e33d5818157bc44c9ef05b6a979
- Related background page: https://app.notion.com/p/38fa3e33d581804e97c5c7b297d292b0
- Official project repo: https://github.com/ZedBiz44/hermes-wp-project

## Live URL Check

All seven listed `zednow.com` funnel URLs returned HTTP 200 during the review:

- Sales page
- Checkout page
- OTO 1 page
- Onboarding form page
- Thank you page
- OTO 2 page
- OTO 2 thank you page

This verifies the pages are reachable, but not that the forms, products, payments, upsells, or automation logic work end to end.

## Findings

### P1 - Official GitHub Source Of Truth Missing From Project Hub

The Notion project hub does not currently name `ZedBiz44/hermes-wp-project` as the project source of truth. That creates a handoff risk because agents may continue writing technical notes to `VPS3-Hermes-Hostinger` or chat-only records.

Recommended fix:

- Add a short `GitHub Source Of Truth` section near the top of the project hub.
- Link to https://github.com/ZedBiz44/hermes-wp-project.
- State that all project-specific code, config, demo notes, issues, and technical tracking belong there.

### P1 - Page Says Sponsor Integrations Are Present Before They Are Proven

The page says the project demonstrates Hermes, NVIDIA Nemotron 3 Ultra, and Stripe Skills in a connected flow, but the checklist still shows Hermes skills, Nemotron config, NemoClaw, and WP skill work as incomplete.

Recommended fix:

- Keep the strong contest positioning, but label these as `Planned / Required For Demo` until live proof exists.
- Add a `Verified Demo Proof` section with checkboxes for:
  - Stripe order test completed.
  - GHL workflow fired.
  - Hermes received or was manually triggered from the customer record.
  - Hermes payment skill installed and shown.
  - NVIDIA/Nemotron active model proof captured.
  - WordPress update check/run proof captured.
  - Report email delivered.

### P1 - Stripe And Hermes Connection Needs A Clear Technical Bridge

The page correctly says to replace the inbound webhook with GHL `Order Submitted`, but it does not clearly state how Hermes receives that event or customer data after GHL fires.

Recommended fix:

- Add a `GHL To Hermes Bridge` section.
- Decide and document one bridge:
  - GHL webhook calls a small endpoint that wakes Hermes.
  - GHL creates a queued job in the project database/dashboard.
  - Manual hackathon fallback: export/contact lookup plus manual Hermes trigger.
- Define the data passed: Stripe/customer ID, email, site URL, subscription status, package, and allowed monthly update count.

### P1 - Credential Storage Needs A Safer Demo Story

The page says WordPress Application Passwords are stored in GHL contact custom fields. That may be fast, but it is risky language for a judged demo unless masking, access control, and cleanup are explicit.

Recommended fix:

- Say credentials are stored as securely as the current demo stack allows and are masked in logs/screens.
- Avoid showing raw Application Passwords in the demo.
- Add a future production note for moving credentials to a secret store or vault-backed reference.

### P2 - Stripe Skills Need To Be Separated From Stripe Billing

The page lists `stripe-link-cli + stripe-projects` as handling subscription billing and purchases. Stripe Billing/Checkout handles subscription billing; Hermes payment skills are the agent-commerce layer.

Recommended fix:

- Rewrite that sponsor bullet as:
  - Stripe Billing/Checkout handles subscription revenue.
  - Stripe webhooks or GHL order events start the workflow.
  - Hermes Stripe skills demonstrate provisioning, controlled spend, or pay-per-call services.

### P2 - `mpp-agent` Is Missing From The Main Sponsor Summary

The checklist includes `mpp-agent`, but the project overview only names `stripe-link-cli + stripe-projects`.

Recommended fix:

- Either include `mpp-agent` in the overview or explicitly mark it as optional if time allows.

### P2 - Demo Video Checklist Does Not Show The Stripe Skill Moment

The Step 8 demo list only includes signup, Hermes update routine, and email report. For the judges, that may look like GHL + WordPress automation, not Hermes + Stripe agent commerce.

Recommended fix:

- Add one of these to the demo checklist:
  - Hermes uses `stripe-projects` to provision a customer resource.
  - Hermes uses `stripe-link-cli` for approved plugin-license purchase.
  - Hermes uses `mpp-agent` for a paid scan/check API.

### P2 - Z-Knowledge Dashboard Is Missing From The Hub

The background page frames Z-Knowledge Dashboard as the proof layer, but the project hub does not currently include dashboard requirements.

Recommended fix:

- Add a `Z-Knowledge Dashboard Proof` section:
  - Customer.
  - Subscription status.
  - WordPress connection status.
  - Last job.
  - Monthly usage.
  - Approvals/spend/provisioning.
  - Next scheduled update.

### P2 - Live Funnel URLs Are Reachable, But Workflow Still Needs Real Test Proof

The seven listed zednow.com pages returned HTTP 200 during review. That only proves the pages load.

Recommended fix:

- Add a separate `End-To-End Proof` checklist:
  - Test Stripe payment submitted.
  - GHL contact created/updated.
  - Tags applied.
  - Email 1 delivered.
  - Onboarding form stores values.
  - Hermes can access the needed values.
  - Report email delivered.

### P3 - Page Has Two Different Authors Across Related Docs

The project hub is marked Manus, while the background page and repo tracking now include Cody. That is fine historically, but it can confuse current ownership.

Recommended fix:

- Add a small changelog:
  - Manus created initial project hub.
  - Cody updated background/source-of-truth/tracking on 2026-06-30.

## Recommended Next Fixes

- Add GitHub source-of-truth section to the Notion project hub.
- Add a `Verified Demo Proof` checklist to separate claims from live proof.
- Add the exact GHL-to-Hermes bridge decision.
- Add Z-Knowledge Dashboard proof requirements.
- Tighten wording around Stripe Billing vs Hermes Stripe skills.
- Add the Stripe skill moment to the demo checklist.
