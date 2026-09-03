# ADR 0002: Defer host-firewall enforcement during active development

- Status: accepted as a temporary risk
- Date: 2026-09-03
- Scope: Debian host network filtering

## Context

The host is undergoing active service development. New default-deny or source-restricted host rules could interrupt Docker-published ports, service discovery, VPN administration, or unfinished workflows. The current Netfilter policy is primarily Docker-generated and does not provide a documented host-input baseline.

## Decision

Do not introduce or activate new host-firewall rules during the current development period. Keep V0.3 open and defer VPN-source validation and firewall enforcement.

## Rationale

- Development currently benefits from fewer networking constraints.
- Docker and service exposure are still changing.
- The exact VPN source as observed by the server has not been verified.
- Applying incomplete rules would create availability and remote-lockout risk.

## Accepted risk

- IPv4 and IPv6 host input currently default to accept.
- Security therefore depends more heavily on router exposure, service binding, authentication, and application-level controls.
- SSH password authentication remains enabled under ADR 0001.

## Guardrails

- Do not add router port forwarding to SSH or administrative services.
- Bind development-only services to loopback or the LAN where practical.
- Review listeners whenever a new service is introduced.
- Keep V0.3 visible as deferred work rather than treating the firewall as complete.

## Revisit triggers

- The service layout becomes stable.
- A service must be exposed beyond the home network or VPN.
- Unexpected listeners or authentication attacks are observed.
- Before the repository reaches v1.0.
