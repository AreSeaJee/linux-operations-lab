# Security baseline

Status: draft; no hardening changes applied yet.

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
