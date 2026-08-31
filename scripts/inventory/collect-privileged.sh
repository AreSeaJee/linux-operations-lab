#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
  printf '%s\n' 'Run this read-only collector through sudo.' >&2
  exit 1
fi

section() {
  printf '\n[%s]\n' "$1"
}

section 'SSH effective policy'
sshd -T | grep -E '^(port|addressfamily|listenaddress|permitrootlogin|passwordauthentication|pubkeyauthentication|authenticationmethods|kbdinteractiveauthentication|usepam|maxauthtries|logingracetime|clientaliveinterval|clientalivecountmax|x11forwarding|allowtcpforwarding|permittunnel|gatewayports|allowusers|allowgroups|denyusers|denygroups) ' || true

section 'Authorized-key metadata'
find /root /home -xdev -path '*/.ssh/authorized_keys' -type f -printf '%m %u:%g %p\n' 2>/dev/null || true

section 'sudo policy'
if [ -n "${SUDO_USER:-}" ]; then
  sudo -l -U "$SUDO_USER" || true
fi
find /etc/sudoers /etc/sudoers.d -maxdepth 1 -printf '%m %u:%g %p\n' 2>/dev/null || true

section 'nftables ruleset'
if command -v nft >/dev/null 2>&1; then
  nft list ruleset || true
else
  printf '%s\n' 'nft command unavailable'
fi

section 'iptables ruleset'
if command -v iptables-save >/dev/null 2>&1; then
  iptables-save || true
fi
if command -v ip6tables-save >/dev/null 2>&1; then
  ip6tables-save || true
fi

section 'SMART health'
if command -v smartctl >/dev/null 2>&1; then
  smartctl --health --attributes /dev/sda || true
else
  printf '%s\n' 'smartctl unavailable; no package was installed by this audit'
fi

section 'Journal integrity and recent high-priority events'
journalctl --verify || true
journalctl --disk-usage || true
journalctl --priority err..alert --since '-30 days' --no-pager --lines 200 || true

section 'Update policy'
apt list --upgradable 2>/dev/null || true
systemctl is-enabled apt-daily.timer apt-daily-upgrade.timer || true
systemctl is-active apt-daily.timer apt-daily-upgrade.timer || true
grep -RhsE '^[[:space:]]*(APT::Periodic|Unattended-Upgrade)::' /etc/apt/apt.conf.d 2>/dev/null || true
if [ -e /var/run/reboot-required ]; then
  printf '%s\n' 'reboot_required=yes'
else
  printf '%s\n' 'reboot_required=no'
fi

section 'Failed systemd units'
systemctl --failed --no-pager || true
