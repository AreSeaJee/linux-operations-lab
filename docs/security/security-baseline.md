# Security baseline

Status: draft; no hardening changes applied yet.

## Observed baseline

- SSH password authentication is enabled.
- No authorized-keys file was found during the privileged metadata audit.
- Root SSH login is key-only rather than fully disabled.
- X11 forwarding and TCP forwarding are enabled.
- SSH listens on all IPv4 and IPv6 addresses.
- Host input policy defaults to accept for IPv4 and IPv6.
- Existing firewall rules are predominantly managed by Docker and do not constitute a documented host-firewall baseline.
- The administrative account has unrestricted password-protected sudo access.

The immediate safe order is: establish and verify public-key access, preserve a recovery session, then design and test the host firewall. Password authentication must not be disabled before key-based access is proven.

The administrator has explicitly chosen to retain SSH password authentication for now. This is recorded as [ADR 0001](../decisions/0001-retain-ssh-password-authentication.md). V0.3 will therefore focus on exposure, logging, rate limiting, and a Docker-compatible IPv4/IPv6 firewall without changing the login method.

Host-firewall enforcement is temporarily deferred during active service development under [ADR 0002](../decisions/0002-defer-host-firewall-during-development.md). This is a documented risk acceptance, not a completed firewall baseline.

## Baseline controls

- inventory every externally reachable listener on IPv4 and IPv6
- verify an explicit default-deny host firewall policy without breaking Docker networking
- require SSH public-key authentication before considering password authentication changes
- verify root login, forwarding, idle-session, and authentication limits
- retain a tested recovery path before access-control changes
- use named administrative accounts and minimal sudo rules
- treat Docker group and socket access as privileged
- isolate service accounts with non-login shells and narrow filesystem access
- document security update cadence and reboot handling
- keep secrets out of Git, shell history, process arguments, and public logs
- record evidence in sanitized form

## Change gate

Every security change requires:

1. observed current state;
2. impact and lockout analysis;
3. backup or recovery path;
4. explicit change scope;
5. validation from a second session where relevant;
6. rollback instructions;
7. repository, GitHub issue, and Notion log update.
