---
description: Start the Autonomous Full Stack Engineer Pipeline sequence
---

When the user types `/engineerworkflow`, orchestrate the development process strictly using project manager commands and roles specified in `.agents/agents.md` and `.agents/skills/`.

### Execution Sequence:
1. Act as the **Full-Stack Engineer** and execute the `generate_code.md` skill based on rules specified in `Technical_Specification.md` and `.agents/rules/projeto.md`.
   *(Wait for the user to explicitly approve the spec. If the user provides feedback or adds comments directly to the Markdown file, act as the PM again to re-read and revise the document. Loop this step until they type "Approved").*