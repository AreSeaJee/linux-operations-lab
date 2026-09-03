# ADR 0001: Retain SSH password authentication temporarily

- Status: accepted as an interim decision
- Date: 2026-09-03
- Scope: Debian host remote administration

## Context

The host currently has one human administrator, SSH password authentication is enabled, and no authorized-key file was found. Disabling password authentication now would remove the known remote login method and create an avoidable lockout risk.

## Decision

Keep SSH password authentication enabled for the current phase. Do not change authentication methods as part of the initial firewall and exposure work.

## Rationale

- The administrator explicitly prefers password authentication at present.
- No tested public-key recovery path exists.
- Preserving reliable administration is more important than applying an isolated hardening setting without its prerequisite.

## Consequences

- Password quality, rate limiting, network exposure, logs, and firewall policy become more important compensating controls.
- Root password login over SSH remains prohibited by the effective key-only root-login setting.
- A future migration to public-key authentication must first be tested in a second session before password authentication is reconsidered.

## Revisit triggers

- SSH becomes reachable from the public Internet.
- Repeated authentication attacks appear in the journal.
- A trusted administration client and recovery key process are established.
- Multi-user or delegated administration is introduced.
