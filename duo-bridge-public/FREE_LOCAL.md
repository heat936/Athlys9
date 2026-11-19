# Free local Duo Bridge proof-of-concept

This is an alternative to the inaccessible Copilot model entitlement and separately billed OpenAI and Anthropic APIs.

**Cost:** $0 in model API calls; standard GitHub-hosted runners on public repositories are free under GitHub's documented policy, subject to service limits and acceptable-use controls.

**Mechanism:** install Ollama on an ephemeral Ubuntu runner; download Qwen2.5 0.5B and SmolLM2 360M; generate a short proposal, then a separate critical review; attach an auditable public JSON artifact.

**Limits:** these are **not** OpenAI GPT or Anthropic Claude. Tiny open models have limited engineering reasoning quality. Public output and workflow logs must never contain private Athlys data. This is a bounded execution per push or manually dispatched run, not continuous real-time chat. No private repository access, authentication, or code merges.

**Acceptance:** success requires both real model inferences and a generated artifact. A runner smoke test alone does not count.
