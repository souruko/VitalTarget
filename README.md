# VitalTarget

A Lord of the Rings Online plugin that displays a morale (health) bar for your current target, with optional time-to-kill (TTK) and raid DPS readouts.

## Features

- **Morale bar** — shows target health as a percentage bar with a numeric label
- **Bubble bar** — a second bar that appears when the target has temporary morale (e.g. Minstrel bubbles), showing the bubble amount and shrinking the main bar proportionally
- **TTK / DPS panel** — an optional side column showing estimated time-to-kill (MM:SS) and raid DPS (in thousands) calculated from morale lost since the target was acquired
- **Draggable window** — enable drag mode from the options panel, reposition anywhere on screen, position saves automatically on mouse-up
- **Per-character save** — all settings are saved to Character scope with an Account scope backup, so each character can have its own layout

## Installation

1. Download or clone this repository.
2. Copy the `VitalTarget` folder into your LotRO plugins directory:

   ```
   Documents\The Lord of the Rings Online\plugins\VitalTarget\
   ```

3. In-game, open the Plugin Manager and load **VitalTarget**, or run:

   ```
   /plugins load VitalTarget
   ```

## Options

Open the options panel via the in-game Plugin Manager (or the settings button if your UI exposes one).

| Section | Setting | Description |
|---|---|---|
| Window | Enable window drag | Activates the drag handle so you can reposition the bar |
| Dimensions | Width | Bar width in pixels (50–500, default 100) |
| Dimensions | Height | Bar height in pixels (10–100, default 30) |
| Dimensions | Timer Width | Width of the TTK/DPS column in pixels (30–200, default 54) |
| Dimensions | Show TTK / DPS panel | Toggles the side column on or off |
| Colors | Morale Bar | Choose from six preset colors for the main morale bar |
| Colors | Bubble Bar | Choose from six preset colors for the temporary morale (bubble) bar |
| Position | Left / Top | Set the bar's screen position numerically and click Apply |
| — | Reset to Defaults | Restores all settings to their factory values |

## How TTK and DPS are calculated

When you acquire a new target, VitalTarget records the target's current morale and the current game time. On each `MoraleChanged` event it computes:

```
TTK  = currentMorale × elapsed / (startMorale − currentMorale)
DPS  = (startMorale − currentMorale) / elapsed / 1000   (displayed as "Xk")
```

Values are hidden (`--`) if no morale has been lost yet or if the result is implausibly large (≥ 6000 seconds).

## File overview

| File | Role |
|---|---|
| `Main.lua` | Entry point, globals, save/load |
| `UI.lua` | `VITALTARGET` window class — all visual controls |
| `Handler.lua` | `MoraleChangedHandler`, `TempMoraleChangedHandler`, `AddCallback`/`RemoveCallback` helpers |
| `Settings.lua` | `Options` panel (ListBox with all settings controls) |
| `Class.lua` | OOP primitives (`class`, `static_class`, `abstract_class`, `final_class`) |
| `Type.lua` | Runtime type information built on top of `Class.lua` |
| `VitalTarget.plugin` | Plugin manifest (name, author, version, entry point) |

## Version

1.0.2 — Author: Souru
