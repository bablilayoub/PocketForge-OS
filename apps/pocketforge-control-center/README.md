# PocketForge Control Center

Graphical handheld settings app for PocketForge OS.

Planned features:

- Dashboard
- Battery status
- Performance modes
- Device information
- Updates
- Per-game profiles

Early work should focus on UI structure and safe profile selection. Low-level
device controls will be added later once the PocketForge Daemon exposes stable
interfaces for them.

The first prototype should use `pocketforge-daemon --json` as its read-only
profile inventory source.
