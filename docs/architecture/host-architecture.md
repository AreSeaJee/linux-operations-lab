# Host architecture

```text
Internet / home network
        |
   router and DNS
        |
 Debian host firewall boundary  <- verification pending
        |
  +-----+---------------------+
  |                           |
SSH administration      Docker/containerd
  |                           |
systemd + journald       bridge networks and volumes
  |                           |
  +-------- ext4 host storage-+
             |
      future backup target
```

## Trust boundaries

- Remote administration crosses the SSH and firewall boundary.
- Docker control is privileged; access to the Docker socket is treated as root-equivalent.
- Containers are workloads, not a substitute for host security or recovery.
- Backup media and credentials must be separated from the protected host.
- Public documentation is a separate trust boundary and contains sanitized evidence only.

## Availability constraints

The host runs existing services. Operations must therefore use maintenance windows, pre-checks, rollback steps, and service-specific verification. Experiments should use isolated test units, ports, paths, accounts, and data.
