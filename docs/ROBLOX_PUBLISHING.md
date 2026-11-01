# Roblox Cloud publishing setup

Universe ID: `2767957106`

## One-time Roblox setup
1. In Roblox Creator Dashboard, open this experience and find its **Places** page. Copy the **start Place ID** (different from the Universe ID).
2. In Creator Dashboard, create an Open Cloud API key with the minimum required permission to publish place files for this experience. Keep it private.
3. In GitHub repository Settings > Secrets and variables > Actions, add the API key as `ROBLOX_OPEN_CLOUD_API_KEY`. Do not put the key in code, issues, or chat.
4. Add the start Place ID as repository variable `ROBLOX_PLACE_ID` and Universe ID as `ROBLOX_UNIVERSE_ID` (value `2767957106`).
5. Configure a CI workflow to build the Rojo project into a Roblox place file and publish it through Roblox's supported Open Cloud place publishing endpoint. Verify supported endpoint, required API key scopes, and file format before enabling deployment.

## Current status
GitHub is connected and Luau source files are present. Publishing is **not yet configured**. Existing GitHub Actions only performs structural validation. Roblox Studio testing and actual deployment are separate steps.

## Safety
Never commit API keys or Roblox cookies. Test first in a nonproduction place before enabling automatic production publishing.
