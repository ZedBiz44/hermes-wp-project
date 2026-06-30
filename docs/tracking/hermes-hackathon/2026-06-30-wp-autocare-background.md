# WP AutoCare by Hermes Background And Tracking

Date: 2026-06-30
Agent: Cody
Status: Active

## Source Of Truth

- Official project repo: https://github.com/ZedBiz44/hermes-wp-project
- Main Notion background page: https://app.notion.com/p/38fa3e33d581804e97c5c7b297d292b0
- Technical journal entry: https://app.notion.com/p/38fa3e33d5818181b499ed0120f65321

## Summary

- The project is WP AutoCare by Hermes, a $50/month WordPress update maintenance service.
- The customer buys through Stripe, enters WordPress connection details, and Hermes performs the backend maintenance workflow.
- The contest story should show a real agent-run business loop: Stripe earns, Hermes operates, NVIDIA/Nemotron reasons, and Z-Knowledge proves the work.

## Important Correction

- The official repo for this project is `ZedBiz44/hermes-wp-project`.
- A prior tracking note was temporarily placed in `ZedBiz44/VPS3-Hermes-Hostinger` because the correct repo had not been identified yet.
- Going forward, all project-specific code, docs, configs, demo notes, and tracking records should go in this repo.

## What Needs Tracking

### Stripe

- $50/month Stripe product and price.
- Stripe Checkout or embedded checkout flow.
- Webhook endpoint and handled events.
- Subscription status mapped to customer service status.
- Customer and subscription IDs stored in the dashboard or project database.
- Stripe payment-skill proof point for the demo.

### Hermes

- Hermes runtime used for the demo.
- Installed payment skills from `official/payments`.
- Workflow that receives Stripe events and creates/updates the customer job.
- Job runner for WordPress update checks and update execution.
- Logs that prove Hermes performed the operational work.

### NVIDIA / Nemotron

- Exact provider/model configuration used in Hermes.
- Visible proof that the NVIDIA/Nemotron path is powering or supporting the agent reasoning.
- Any NemoClaw/safety runtime configuration used in the demo.

### WordPress

- Test WordPress site.
- ZedBiz WordPress plugin endpoint or WordPress REST API path.
- Secure credential onboarding method.
- Update check workflow.
- Update execution workflow.
- Before/after verification proof.

### Z-Knowledge Dashboard

- Customer record.
- Stripe subscription status.
- WordPress connection status.
- Monthly update count.
- Last job status.
- Approval/spend/provisioning log.
- Next scheduled update.

### Submission

- 1-3 minute demo video.
- Tweet/X post tagging Nous Research and relevant sponsors.
- Discord submission link posted.
- Typeform submitted.

