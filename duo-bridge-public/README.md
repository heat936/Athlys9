# Duo Bridge — public runner, private project

This directory tests GitHub-hosted runners on the **public** heat936/Athlys9 repository. It does not contain private Athlys application code or the private handoff log.

## Security separation
- Public runner: only generic, non-confidential smoke tests and sanitized review tasks.
- Private source of truth: heat936/Athlys2, never cloned into this workflow.
- Any future privileged bridge needs explicit scoped credentials and must prevent untrusted public issues or pull requests from accessing secrets.
- No model credentials are included. A successful smoke test proves only runner availability, **not** an OpenAI–Claude conversation.

## Acceptance gates
1. Runner smoke job reaches conclusion success with a non-empty runner and completed steps.
2. An authorized model backend is configured and individually verified before enabling model calls.
3. A real OpenAI response and an independently generated Claude response must be observed.
4. Public logs must never contain private project content.
