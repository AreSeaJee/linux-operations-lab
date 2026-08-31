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

## Evidence gaps

The next read-only privileged audit should capture effective SSH settings, nftables/iptables policy, sudo rules, authorized-key metadata, SMART status, full journal health, and the exact update policy. Raw sensitive output must remain outside Git.
