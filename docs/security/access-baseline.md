# Access, users, and permissions baseline

Inventory date: 2026-09-03

No account, group, permission, ACL, SSH key, container, or service was changed during this review.

## Current state

- One root account and one regular interactive human account exist.
- Twenty-one additional local accounts are non-interactive system or service accounts; none has an interactive shell.
- The human administrator has unrestricted, password-protected sudo access.
- The administrator is a member of the `docker` group and can access the Docker socket; this is root-equivalent privilege.
- The administrator also retains several local hardware and desktop-oriented supplementary groups that may not all be necessary on a headless server.
- The administrator's home directory is private with mode `0700`.
- The repository directory uses mode `0775`, but its private primary group has no additional members.
- The administrator password does not expire under the current local aging policy.
- No authorized-keys file was found during the earlier privileged host audit.
- Root and the human administrator have set passwords; no account has an empty password.
- All inspected system-account password entries are locked.
- The `acl` user-space tools were installed after explicit approval.
- No extended ACL was found within the defined scan depth under `/etc`, `/opt`, `/srv`, `/home`, or Docker volume storage.
- Nine active systemd services use the default/root execution identity; two system services use dedicated non-login identities, in addition to the regular user's service manager.
- Of 23 running containers, 13 have an empty or root container user configuration and 10 declare a non-root identity. Container root is namespaced but increases impact when combined with broad mounts, capabilities, or socket access.
- Standard subordinate UID and GID ranges exist for the regular account.
- No world-writable directories were found within the selected shallow scan of `/etc`, `/opt`, `/srv`, and `/var/lib`.

## Existing strengths

- Only one human login account exists.
- System accounts use non-interactive shells.
- The home directory is not accessible to other local users.
- sudo requires authentication and uses a pseudo-terminal.
- The project group currently has no additional members.
- Several services and containers already use explicit non-root identities.

## Risks and improvement potential

1. Docker group membership bypasses normal sudo controls and auditing boundaries.
2. SSH currently relies on password authentication because no authorized-key file was found.
3. Unrestricted sudo is simple for a single administrator but does not demonstrate least privilege.
4. Desktop and removable-media groups should be justified individually on a headless server before any removal is proposed.
5. Container workloads with root as their configured identity require mount, capability, and socket review in their owning project.
6. Password aging is effectively unlimited; the appropriate control depends on remote access, password quality, and the future key-authentication policy.
7. No named ACL is currently part of the reviewed access model; future ACL use therefore needs explicit documentation and tests.

## Deliberate non-changes

- Do not remove sudo or Docker access before a tested alternative administration and recovery path exists.
- Do not change SSH authentication before public-key login is proven in a second session.
- Do not remove supplementary groups based only on their names; first verify actual hardware and workflow dependencies.
- Do not change service or container identities without mapping file ownership, mounts, capabilities, and startup behavior.
- Do not introduce service accounts until a concrete service requires one.

## V0.2 conclusion

The current access model is simple but highly privileged: one human administrator has full sudo and Docker control, while system accounts are non-interactive and password-locked. Classical Unix mode bits are used without named ACLs in the reviewed paths. No empty passwords or SSH authorized-key files were found.

The next safe improvement belongs to v0.3: establish and verify public-key SSH access before changing password authentication, root-login policy, forwarding, or firewall rules.
