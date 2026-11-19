# Duo Bridge — direct OpenAI × Anthropic API backend

GitHub Models inference was retired in July 2026. Copilot CLI on heat936 produced "Access denied by policy settings". This replacement uses the supported first-party API endpoints, avoiding Copilot licensing.

## Preflight workflow
The workflow `.github/workflows/duo-direct-providers.yml` runs on a public GitHub-hosted runner. If either repository Actions secret is absent, it **does not make external model calls** and reports "not activated" in the run summary. If both secrets exist, it runs a single low-output, public, synthetic two-model handshake.

Required Actions secrets on heat936/Athlys9:
- `OPENAI_API_KEY` — authorized OpenAI API key
- `ANTHROPIC_API_KEY` — authorized Anthropic API key

Optional repository variables: `DUO_OPENAI_MODEL` and `DUO_ANTHROPIC_MODEL`; defaults are `gpt-4.1` and `claude-sonnet-4-6`.

**This is not a real-time bridge between the ChatGPT and Claude.ai conversations.** It establishes a machine-to-machine API bridge if valid credentials and billing are available. A GitHub Actions run is episodic, not low-latency live chat. For privacy, do not copy private source code or issue bodies from heat936/Athlys2 to this public workflow. A private production bridge needs separate authentication and controlled storage of messages and outputs.

No automated merges. No cost-incurring requests if either key is missing. Provider API usage may be billed if both are present.
