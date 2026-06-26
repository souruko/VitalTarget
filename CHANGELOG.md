# Changelog

All notable changes to VitalTarget are documented here.

## [1.0.2] — 2026-06-27

### Added
- Color picker in the options panel: clickable swatches for both the morale bar and bubble bar (6 presets each); color is saved and restored across sessions
- Position section in options: numeric Left/Top inputs with an Apply button as an alternative to drag-to-move
- Reset to Defaults button in options
- Input validation and clamping on all dimension fields (width 50–500, height 10–100, timer width 30–200)
- Gold-themed section headers and horizontal dividers throughout the options panel

### Fixed
- `saveFile.heigth` typo corrected to `saveFile.height`; HEIGHT now loads correctly for all characters
- Bar colors were saved as a Color object reference (not serializable); now saved and loaded as individual R/G/B/A float components
- TTK/DPS panel now shows `--` when target morale has not yet changed, preventing divide-by-zero and misleading values
- Removed stray `save()` call that ran on every plugin load

### Removed
- Dead `TargetChangeHandler` function (leftover from an earlier multi-frame design)
- Debug `Turbine.Shell.WriteLine` call guarded by a `DEBUG_ENABLED` global that was never set

## [1.0.1] — 2026-06-26

Initial release.

- Morale bar showing target health as a percentage bar with a numeric label
- Bubble bar for temporary morale (e.g. Minstrel absorbs), shrinking the main bar proportionally
- Optional TTK / DPS panel (MM:SS time-to-kill and raid DPS in thousands)
- Draggable window via a toggle in the options panel; position saves on mouse-up
- Settings persisted per-character with an account-wide backup
- In-game options panel wired to `plugin.GetOptionsPanel`
