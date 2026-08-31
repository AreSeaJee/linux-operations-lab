# Backup and restore

Current status: no verified host-level backup and restore workflow.

## Definition of done

A backup is successful only when:

- scope and exclusions are documented;
- backup data is readable and integrity-checked;
- encryption and key recovery are understood;
- retention and failure notifications are configured;
- a restore is performed into an isolated destination;
- permissions, ownership, content, and service behavior are verified;
- restore duration and evidence are recorded.

## Planned restore levels

1. single configuration file;
2. directory with ownership and ACLs;
3. systemd service configuration and data;
4. container-host configuration and selected volume data;
5. disaster-recovery runbook for rebuilding the host.

Tool selection remains open until data volume, backup target, threat model, RPO, and RTO are defined.
