# PocketForge Daemon

Background system service for PocketForge OS.

The current daemon is a safe early skeleton. It starts as a systemd service,
loads PocketForge device and performance profile metadata, and logs the profiles
available on the image.

Current behavior:

- Read `/usr/share/pocketforge/device-profiles`
- Read `/usr/share/pocketforge/performance-profiles`
- Log detected profile IDs and names
- Refresh metadata periodically

Future responsibilities:

- Device detection
- Performance profile application
- Battery modes
- Display settings
- Per-game profile application
- Communication with the Control Center and Overlay

This service is currently a project placeholder. Early alpha builds should keep
the daemon minimal until hardware-safe control paths are designed and tested.
