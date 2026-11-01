# Change the game from ChatGPT
1. Ask ChatGPT to edit the connected GitHub repository `biotv333-pixel/A320-Flight-Simulator`.
2. ChatGPT commits code changes. They do not automatically appear on your PC.
3. Install Git for Windows and Rojo CLI + Studio plugin (one-time setup).
4. Clone the repository using `git clone https://github.com/biotv333-pixel/A320-Flight-Simulator.git`. A Git clone is required, not GitHub's Download ZIP.
5. Open PowerShell in the cloned project and run `powershell -ExecutionPolicy Bypass -File .\sync-and-serve.ps1`.
6. Open Roblox Studio, open your place, and connect the Rojo plugin to the local server.
7. When ChatGPT commits further changes, stop the script with Ctrl+C and run it again to pull the latest version and restart Rojo.

The script refuses to pull over uncommitted local changes and uses fast-forward-only updates. It does not publish the Roblox game, test the scripts, or provide ChatGPT direct desktop access.
