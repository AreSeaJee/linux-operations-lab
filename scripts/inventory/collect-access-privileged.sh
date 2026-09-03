#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
  printf '%s\n' 'Run this read-only collector through sudo.' >&2
  exit 1
fi

section() {
  printf '\n[%s]\n' "$1"
}

section 'Password state classes'
awk -F: '
  FNR == NR {
    uid[$1] = $3
    shell[$1] = $7
    next
  }
  {
    kind = "system"
    if (uid[$1] == 0) kind = "root"
    else if (uid[$1] >= 1000 && uid[$1] < 65534 && shell[$1] !~ /(nologin|false)$/) kind = "human"

    state = "set"
    if ($2 == "") state = "empty"
    else if ($2 ~ /^[!*]/) state = "locked"

    count[kind, state]++
  }
  END {
    kinds[1] = "root"; kinds[2] = "human"; kinds[3] = "system"
    states[1] = "set"; states[2] = "locked"; states[3] = "empty"
    for (k = 1; k <= 3; k++)
      for (s = 1; s <= 3; s++)
        printf "%s_%s=%d\n", kinds[k], states[s], count[kinds[k], states[s]] + 0
  }
' /etc/passwd /etc/shadow

section 'Authorized-key file count'
find /root /home -xdev -path '*/.ssh/authorized_keys' -type f -printf '.' 2>/dev/null | wc -c

section 'Extended ACL summary'
for path in /etc /opt /srv /home /var/lib/docker/volumes; do
  if [ ! -e "$path" ]; then
    continue
  fi
  case "$path" in
    /etc) label=etc ;;
    /opt) label=opt ;;
    /srv) label=srv ;;
    /home) label=home ;;
    /var/lib/docker/volumes) label=docker-volumes ;;
  esac
  count=$(find "$path" -xdev -maxdepth 4 -exec getfacl -s -p --absolute-names {} + 2>/dev/null | awk '/^# file:/{n++} END{print n+0}')
  printf '%s extended_acl_objects_within_depth_4=%s\n' "$label" "$count"
done
