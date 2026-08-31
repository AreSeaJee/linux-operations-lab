# Redaction policy

## Never publish

- passwords, tokens, API keys, cookies, private keys, recovery codes, or secret values
- personal names, email addresses, account identifiers, and home-directory names
- real public IP addresses, IPv6 prefixes, MAC addresses, serial numbers, and router identifiers
- internal hostnames, domain names, exact network topology, or unnecessary private addresses
- raw logs or configuration containing any of the above

## Publication replacements

| Real value | Public replacement |
|---|---|
| Hostname | `server.example.invalid` |
| IPv4 address | RFC 5737 address such as `192.0.2.10` |
| Domain | `.example` or `.invalid` name |
| User | `<admin-user>` or `<service-account>` |
| Secret | `<redacted>` or environment-variable reference |

Raw evidence stays outside Git. Sanitized summaries should retain the operational conclusion without retaining identifying data.
