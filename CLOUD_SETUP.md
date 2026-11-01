# Cloud build and publishing plan

GitHub Actions structural checks are automatic. They do not run Roblox Studio or verify flight physics.

## Before real publishing can be enabled
1. Create a Roblox experience and obtain its universe and place IDs.
2. Configure a narrowly scoped Roblox Open Cloud API key as a GitHub Actions secret named `ROBLOX_API_KEY`. Never paste the key into ChatGPT or commit it.
3. Configure repository variables `ROBLOX_UNIVERSE_ID` and `ROBLOX_PLACE_ID`.
4. Configure the `roblox-production` GitHub environment with required reviewers.
5. Add a pinned, verified Rojo build toolchain to produce an .rbxl place file.
6. Add a tested Open Cloud Place Publishing API upload step, initially to a staging place.
7. Verify that code-generated assets and any Studio-only assets are preserved before enabling production deployments.

The current publishing workflow is **not** a working deployment. It only checks prerequisites and prints a status message. It never uploads a place.

Future code updates should use pull requests and only merge after explicit user approval.
