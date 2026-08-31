# Sanitized host inventory

Inventory date: 2026-08-31

This document contains portfolio-relevant facts only. Identifiers and network details are deliberately generalized.

## Current state

| Area | Observation |
|---|---|
| Operating system | Debian 13 (Trixie), amd64 |
| Kernel | Debian 6.12 series |
| CPU | Four-core Intel x86-64 CPU with VT-x |
| Memory | Approximately 16 GiB RAM and 12 GiB swap |
| Storage | One approximately 240 GB SATA disk |
| Filesystems | EFI/FAT32, root/ext4, swap |
| Capacity | Root filesystem below 10% utilization; inode use below 5% |
| Network | One Ethernet interface using DHCP; IPv4 and IPv6 enabled |
| DNS | Router-provided recursive DNS |
| Host services | SSH, Docker, containerd, cron, journald, time synchronization |
| Listeners | SSH on IPv4/IPv6, HTTP on LAN IPv4, one loopback-only application port |
| Timers | APT, dpkg backup, log rotation, tmpfiles cleanup, TRIM, ext4 scrub |
| Containers | More than a dozen active containers; treated as existing workloads |
| Logging | Persistent journal and log rotation enabled |
| Backup | No verified host backup and restore workflow detected |
| Git | Project directory initially had no local Git history |

## Existing strengths

- Current Debian release and low resource pressure
- persistent system journal and scheduled log rotation
- time synchronization, filesystem scrub, and SSD TRIM enabled
- no failed systemd units during the initial observation
- loopback binding used for a non-public application port
- Docker APT repository uses a dedicated signing key

## Risks and open questions

- security-related packages and a newer kernel were pending
- no proven host backup or restore test
- a single physical disk is a recovery risk
- active firewall policy could not be verified without privileged read access
- SSH listens on IPv6 while global IPv6 addressing is present
- effective SSH authentication and root-login settings remain to be verified
- X11 forwarding is enabled
- Docker group membership provides root-equivalent control
- automatic APT timers exist, but a complete unattended-upgrade policy is not proven
- journal retention limits are not explicitly documented

## Deliberate non-changes

The inventory did not modify running containers, port mappings, SSH, firewall rules, users, groups, mounts, packages, kernel, data, or existing deployment repositories.

## Follow-up validations

- External IPv6 reachability depends on router and upstream policy and will be tested in v0.3 from outside the home network.
- A restore test remains a v0.6 requirement before any backup can be considered successful.

## Read-only audit progress

An unprivileged follow-up audit confirmed:

- `nftables.service` is disabled and inactive, while Netfilter/nftables kernel modules are in use;
- this does not prove that the host has no active rules because Docker can create runtime rules independently of `nftables.service`;
- three SSH host-key files exist, keyboard-interactive authentication is explicitly disabled, PAM is enabled, and X11 forwarding is enabled;
- no authorized-keys file exists for the current administrative account;
- both APT timers are enabled and active, but `unattended-upgrades` and `needrestart` are not installed;
- six packages were pending, including security updates for the kernel and OpenSSL;
- no reboot-required marker was present;
- persistent user journals passed integrity verification and occupied approximately 12 MiB;
- no failed systemd units were present;
- `smartmontools` was initially absent, so the first pass could not evidence SMART health.

The privileged collector was run locally. Its raw report remains under the ignored `inventory/private/` path and is not part of Git history.

## Privileged audit findings

The locally executed privileged collector confirmed:

- SSH listens on all IPv4 and IPv6 addresses on the standard port;
- public-key authentication is enabled, but no authorized-keys file was found for the inspected accounts;
- password authentication is enabled;
- direct root login is restricted to key-based authentication;
- X11 and TCP forwarding are enabled;
- the administrative account has unrestricted sudo access with password authentication;
- IPv4 and IPv6 host `INPUT` policies accept traffic by default;
- the active Netfilter ruleset is primarily Docker-generated NAT and forwarding policy, not a documented host-firewall baseline;
- IPv4 forwarding defaults to drop outside the Docker-managed paths, while IPv6 forwarding defaults to accept;
- Docker publishes HTTP and an application port through IPv4 rules; the application port is additionally constrained to loopback by a raw-table rule;
- no failed systemd units were present;
- the reviewed high-priority journal entries contained no unexplained active service failure; most authentication errors were produced by the read-only audit attempts;
- six updates remained pending, including kernel and OpenSSL security updates, and no reboot marker was present;
- after explicit approval, `smartmontools` was installed and the package enabled its default monitoring daemon;
- the SSD's overall SMART assessment passed;
- no retired blocks, reallocation events, reported uncorrectable errors, offline uncorrectable errors, or interface CRC errors were reported;
- the observed temperature was within the device's recorded operating range;
- vendor-specific wear indicators did not cross their declared failure thresholds;
- the raw SMART report remains private and ignored by Git.

The default SMART daemon now scans available devices periodically and reports through the distribution's local runner. Notification delivery has not yet been proven and belongs in the monitoring milestone.

## Priority conclusion

Before disabling password authentication, a tested SSH public-key login and recovery session must exist. After that, define a Docker-compatible host firewall for IPv4 and IPv6. Do not apply either change remotely without a second active session and rollback path.
