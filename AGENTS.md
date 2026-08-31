# AGENTS.md

## Mission

Maintain this repository as a public, reproducible Linux operations portfolio. Focus on Debian host administration rather than application delivery or Docker Compose architecture.

## Safety rules

- Default to read-only discovery on real hosts.
- Do not restart, disable, reconfigure, delete, or expose existing services without explicit approval.
- Explain impact, validation, and rollback before risky changes.
- Never commit passwords, tokens, private keys, personal data, real public addresses, internal hostnames, or unnecessary private network details.
- Use placeholders such as `server.example.invalid`, `192.0.2.10`, and `<service-account>`.
- Treat Docker group membership as root-equivalent access.
- Never describe a backup as successful until a restore has been tested.

## Workflow

1. Capture the current state and evidence.
2. Separate observations, strengths, risks, recommendations, and deliberate non-changes.
3. Make one small change at a time.
4. Test expected behavior and failure behavior.
5. Update repository docs, GitHub issue status, and the linked Notion project log.
6. Automate only after the manual procedure is understood and documented.

## Quality

- Shell scripts must use safe defaults and pass ShellCheck where applicable.
- Examples must be idempotent or clearly state otherwise.
- Troubleshooting scenarios document symptoms, hypotheses, diagnostic commands, findings, fix, verification, rollback, and learning.
- Backup work documents scope, retention, encryption, RPO/RTO, restore procedure, and restore evidence.
