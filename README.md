# A320 Flight Simulator — KJFK prototype

Roblox Studio + Rojo starter project. This is **not** a study-level flight model yet.

## Install
1. Install Roblox Studio, Rojo CLI and Rojo Studio plugin.
2. Clone/download this repository to your Windows PC.
3. Open a terminal inside the project folder and run `rojo serve`.
4. In Roblox Studio create a Baseplate, open the Rojo plugin and connect to the local server.
5. Press Play and sit in the A320 prototype PilotSeat.

## Controls
- Shift: increase throttle
- Ctrl: decrease throttle
- W/S: pitch up/down
- A/D: roll right/left

## Notes
The aircraft is an anchored scripted prototype, with a deliberately simplified flight model. Speed and altitude are in Roblox studs, not knots or feet. The runway is a placeholder and is **not** a real JFK runway layout. Future versions need aerodynamic validation, proper taxi/landing dynamics, and full cockpit systems.
