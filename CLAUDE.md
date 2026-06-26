# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

VitalTarget is a Lord of the Rings Online (LotRO) plugin written in Lua. It displays a morale (health) bar for the player's current target, with optional time-to-kill (TTK) and raid DPS columns. It runs inside the game via the Turbine plugin engine — there is no build step, linter, or test runner.

## Directories

- **`/home/souru/lotro/documents_live/plugins/VitalTarget/`** — source of truth (this repo)
- **`/home/souru/.local/share/Steam/steamapps/compatdata/212500/pfx/drive_c/users/steamuser/Documents/The Lord of the Rings Online/plugins/VitalTarget/`** — live game path (Wine/Proton prefix); changes here take effect on next `/plugins load VitalTarget` in-game
- **`/home/souru/lotro/PluginReleases/`** — archived ZIP releases

To deploy: copy changed files from the source directory to the live game path.

## Architecture

Load order is determined by `Main.lua` imports. The dependency chain is:

```
Type.lua  ←→  Class.lua   (mutually importing; Class bootstraps the OOP system,
                            then Type defines the Type final_class on top of it)
     ↓
Main.lua  →  Handler.lua  →  UI.lua  →  Settings.lua
```

### Files

| File | Role |
|---|---|
| `Class.lua` | OOP primitives: `class()`, `static_class()`, `abstract_class()`, `final_class()`. Sets up metatable-based single inheritance and mixin support. |
| `Type.lua` | Runtime type information. `Type` is a `final_class` that wraps any Lua value and exposes `IsClass()`, `IsA()`, `GetBaseClass()`, etc. |
| `Main.lua` | Entry point. Declares all display globals (`WIDTH`, `HEIGHT`, `LEFT`, `TOP`, `TTKSPACE`, `SHOW_TTKSPACE`, `MORALECOLOR`, `BUBBLECOLOR`, `FONT`). Handles `save()` / `loadSaveFile()` via `Turbine.PluginData` (Character scope primary, Account scope backup). Instantiates `VITALTARGET` and `Options`, wires `plugin.GetOptionsPanel`. |
| `UI.lua` | Defines the `VITALTARGET` class (extends `Turbine.UI.Window`). Owns all visual controls: `moraleBar`, `bubbleBar` (temporary morale / "bubble"), `percentLabel`, `ttkLabel`, `raidDPSLabel`, and `moveControl` (drag handle). Key methods: `Constructor`, `ShowTTKSpaceChanged`, `Resize`, `UpdateWindow`. |
| `Handler.lua` | `AddCallback` / `RemoveCallback` helpers (allow multiple handlers per event). `MoraleChangedHandler` updates the morale bar width, percent label, TTK, and DPS. `TempMoraleChangedHandler` handles the bubble (temporary morale) bar. Both reference the `OBJECT` global. |
| `Settings.lua` | `Options` class (extends `Turbine.UI.ListBox`). Builds the in-game settings panel: move-mode checkbox, width/height/timer-width text inputs with an Accept button, and Show Extra Window checkbox. |

### Key globals

- `OBJECT` — singleton `VITALTARGET` instance
- `LOCALPLAYER` — `Turbine.Gameplay.LocalPlayer:GetInstance()`
- `ACTUALWIDTH` — effective bar width (shrinks when a bubble is present; equals `WIDTH` otherwise)
- `MOVE` — whether the drag handle is active (not persisted to save file)

### Event flow

1. `LOCALPLAYER.TargetChanged` → `OBJECT:UpdateWindow(newTarget)` — detaches callbacks from old target, attaches to new one, resets morale tracking state
2. Target's `MoraleChanged` / `BaseMaxMoraleChanged` / `MaxMoraleChanged` → `MoraleChangedHandler` — updates bar width, percent label, TTK, and DPS
3. Target's `TemporaryMoraleChanged` / `MaxTemporaryMoraleChanged` → `TempMoraleChangedHandler` — shows/hides bubble bar and shrinks `ACTUALWIDTH`

### Turbine API conventions

- All UI controls inherit from `Turbine.UI.Control` or `Turbine.UI.Window`
- Events are assigned by direct field assignment: `object.EventName = function(sender, args) ... end`; `AddCallback`/`RemoveCallback` wrap this to support multiple handlers on the same event
- Positions and sizes are in pixels; `SetPosition(left, top)` and `SetSize(width, height)`
- `Turbine.Engine:GetGameTime()` returns seconds as a float
