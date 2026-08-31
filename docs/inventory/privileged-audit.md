# Privileged read-only audit

This audit fills the remaining v0.1 evidence gaps without changing host configuration or service state.

## Run locally

```bash
mkdir -p inventory/private
chmod 700 inventory/private
sudo scripts/inventory/collect-privileged.sh > inventory/private/privileged-audit.txt
chmod 600 inventory/private/privileged-audit.txt
```

The output is intentionally excluded from Git. Review and sanitize it before transferring conclusions to public documentation. Never publish usernames, addresses, hostnames, key material, detailed firewall sources, or internal paths.

The collector does not install `smartmontools`. Until that package is explicitly approved and installed, the SMART section records that health data is unavailable.
