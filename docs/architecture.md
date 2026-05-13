# PocketForge Architecture

PocketForge OS is split into small components so early alpha work can stay
stable while the handheld stack grows.

## Components

- **PocketForge Daemon**: system service for device and profile metadata.
- **PocketForge Control Center**: graphical settings app for handheld mode,
  profiles, updates, and device information.
- **PocketForge Overlay**: in-game quick settings surface.
- **Device Profiles**: shared YAML metadata for supported handhelds.
- **Performance Profiles**: shared YAML metadata for safe operating intents.

## Current Contract

The daemon is read-only today. It loads shared metadata and exposes profile
inventory through:

```bash
pocketforge-daemon --json
```

The Control Center should treat this as the first read-only contract. Hardware
control APIs will be designed separately and added only after they can be tested
safely on real devices.

## Safety Rules

- Do not add TDP, fan, firmware, or EC writes during this foundation phase.
- Prefer metadata and validation before privileged controls.
- Keep image builds stable and optional during rapid development.
- Run `scripts/check-local` before committing active work.
