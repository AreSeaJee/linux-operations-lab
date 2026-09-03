# ADR 0003: Defer centralized host backup

- Status: accepted as a temporary risk
- Date: 2026-09-03
- Scope: Debian host backup and recovery

## Context

The current workloads manage backups individually at container or application level. Introducing an additional host-wide backup during active development is not desired at this time.

## Decision

Defer a centralized host-backup implementation. Keep V0.5 and V0.6 open until backup scope and practical restore tests are addressed.

## Accepted limitations

- Container-level backups do not automatically protect host configuration, systemd units, package state, firewall policy, Compose definitions, environment files, bind mounts, or encryption keys.
- Independent workload backups may use inconsistent retention, encryption, monitoring, and recovery procedures.
- No backup is considered successful by this project until its restore has been tested and evidenced.
- Full-host disaster recovery is not currently demonstrated.

## Guardrails

- Each workload remains responsible for documenting its backup target, retention, encryption, failure notification, and restore procedure.
- Backup credentials and raw configuration remain outside the public repository.
- New persistent services must identify where their state lives and how it is restored.
- Do not close the backup or restore milestones solely because backup jobs exist.

## Revisit triggers

- A container restore fails or has not been tested.
- Important state exists outside the documented workload backups.
- Host rebuild time becomes operationally important.
- Service development stabilizes.
- Before the repository reaches v1.0.
