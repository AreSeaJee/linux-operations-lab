# Linux Operations Lab

Public portfolio lab for Linux administration, operations, security, troubleshooting, backup, and recovery on Debian.

The goal is to demonstrate understanding of the Linux host beneath container workloads: how it is installed, structured, secured, patched, observed, diagnosed, backed up, and restored.

## Scope

- Debian administration and package management
- users, groups, sudo, permissions, and service accounts
- systemd services, timers, journald, and log rotation
- networking, DNS, routing, SSH, and host firewalling
- storage, mounts, filesystems, and capacity management
- patching, monitoring, backup, restore, and disaster recovery
- reproducible troubleshooting scenarios
- shell automation first, Ansible after the manual process is understood

Docker is treated as a host workload. Application delivery and Compose-oriented work belong in the separate `homeops-devops-lab` project.

## Current status

Version `v0.1` is in progress. A read-only baseline inventory has been completed and sanitized for publication. No production service was changed during discovery.

Start with:

- [Inventory](docs/inventory/host-inventory.md)
- [Architecture](docs/architecture/host-architecture.md)
- [Security baseline](docs/security/security-baseline.md)
- [Roadmap](docs/roadmap.md)
- [Redaction policy](inventory/redaction-policy.md)

## Operating principles

1. Observe before changing.
2. Explain impact before risky actions.
3. Prefer small, reversible changes.
4. Understand manually before automating.
5. Test and document every milestone.
6. A backup is successful only after a practical restore test.
7. Never publish secrets or unnecessary internal details.

## Repository boundaries

- `Trixway`: reproducible Debian/Linux desktop and endpoint engineering
- `homeops-devops-lab`: Docker, CI/CD, testing, deployment, and delivery
- `linux-operations-lab`: Linux administration, operations, security, and recovery
- `sovereign-workplace-lab`: future digital-sovereignty and M365/OSS migration work

## Safety

This lab shares a host with existing workloads. Examples use placeholders and test resources. Production services, firewall rules, storage, and access configuration are never changed without an explicit impact assessment and rollback plan.

## License

MIT
