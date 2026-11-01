# ChatGPT-managed A320 Flight Simulator workflow

This repository is the source of truth for the Roblox A320 at JFK project.

## Change process
1. Describe a feature in ChatGPT.
2. ChatGPT inspects existing files and creates a dedicated feature branch.
3. ChatGPT proposes changes in a GitHub pull request, without overwriting the main branch.
4. Review and explicitly approve the proposed change before merging.
5. Automated checks should run where possible. Do not claim an in-Studio test unless it was actually performed.

## Local-free aspiration
The developer should not need to download code to request or review changes. GitHub pull requests support this part. Automatic Roblox testing and publishing are **not yet configured**. They may require Roblox Open Cloud credentials, an experience/universe ID, and additional infrastructure. Never commit credentials or tokens.

## Roadmap
- Establish reproducible project builds and CI validation
- Verify existing flyable A320 prototype
- Improve flight physics and control surfaces
- Add cockpit avionics and A320 systems
- Develop JFK layout and multiplayer functionality
- Evaluate authorized Roblox cloud publishing

## Control scheme
W pitch up, S pitch down, A roll left, D roll right, Shift increase throttle, Ctrl decrease throttle.

## Safety
Keep `main` stable; avoid force pushes. Use pull requests for feature work.
