# Troubleshooting methodology

Each scenario uses the same evidence-driven structure:

1. **Symptom** — what the operator or monitoring sees.
2. **Impact** — affected users, services, and data.
3. **Recent changes** — relevant changes before the incident.
4. **Hypotheses** — ordered by likelihood and risk.
5. **Diagnostics** — commands and expected signals.
6. **Finding** — evidence that identifies the cause.
7. **Fix** — smallest safe correction.
8. **Verification** — positive and negative tests.
9. **Rollback** — how to return to the prior state.
10. **Learning** — prevention, monitoring, and automation opportunities.

Planned scenarios include a failed service, wrong permissions, occupied port, full filesystem, DNS failure, missing mount, invalid configuration, and a service account with insufficient or excessive access.
