# Hermes WP Project

Date: 2026-06-30 | Author: Cody | Status: Active

This repository is the technical source of truth for the WP AutoCare by Hermes hackathon project.

## Project

WP AutoCare by Hermes is a $50/month WordPress maintenance offer where a customer subscribes through Stripe, securely connects a WordPress site, and Hermes runs the backend update workflow.

## Core Demo Loop

- Stripe subscription starts or updates the customer record.
- Stripe webhook triggers the Hermes onboarding/workflow lane.
- Customer submits WordPress site connection details through a secure form.
- Hermes verifies subscription status before running update work.
- Hermes uses the ZedBiz WordPress plugin or WordPress REST API to check and run updates.
- NVIDIA/Nemotron should be visible as the reasoning layer where available.
- Hermes payment skills should show a real Stripe-connected agent operation such as provisioning, approved spend, or pay-per-call service use.
- Z-Knowledge Dashboard should show the customer, subscription, job status, update history, and approvals.

## Current Tracking

- Main background page: https://app.notion.com/p/38fa3e33d581804e97c5c7b297d292b0
- Technical journal entry: https://app.notion.com/p/38fa3e33d5818181b499ed0120f65321
- Current project tracking note: docs/tracking/hermes-hackathon/2026-06-30-wp-autocare-background.md

