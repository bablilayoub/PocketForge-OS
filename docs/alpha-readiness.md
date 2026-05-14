# Alpha Readiness

PocketForge OS alpha means the project can produce a bootable Fedora
Atomic-based image that is useful for early handheld testing without pretending
the custom handheld stack is finished.

## Alpha Scope

- Fedora Atomic / Universal Blue Kinoite base builds successfully.
- KDE Plasma desktop is present.
- Steam, Gamescope, MangoHud, and GameMode are installed.
- Experimental PocketForge Gaming Mode session is installed.
- PocketForge firstboot service is installed and enabled.
- PocketForge Daemon is installed, enabled, and read-only.
- Daemon JSON inventory contract is validated.
- Daemon reports read-only DMI device detection when a profile matches.
- Control Center prototype is installed in the image and can display daemon
  inventory metadata.
- Device profiles exist for the first target handheld families.
- Performance profiles are metadata-only and validated.
- Local checks pass with `scripts/check-local`.
- Full container image build passes when manually triggered.

## Not In Alpha

- TDP control
- Fan control
- Firmware or embedded-controller writes
- Automatic device-specific tuning beyond read-only detection
- Installer polish
- Production recovery UX
- Stable gaming-session switching beyond the experimental Gamescope session

## Alpha Exit Checklist

- [ ] `scripts/alpha-status` reports local alpha foundation readiness.
- [ ] `scripts/check-local` passes.
- [x] Local AMD64 container image build completes.
- [ ] Manual `Validate project files` workflow passes.
- [ ] Manual `Build container image` workflow passes.
- [ ] Published GHCR image can be pulled.
- [ ] Alpha boot runbook has been followed for the candidate.
- [ ] VM boot test reaches KDE Plasma.
- [ ] PocketForge Gaming Mode session starts Steam Big Picture through Gamescope.
- [ ] `pocketforge-daemon.service` is enabled in the image.
- [ ] `pocketforge-firstboot.service` completes once.
- [ ] `journalctl -u pocketforge-daemon` shows loaded profiles.
- [ ] PocketForge Control Center launcher opens the prototype.
- [ ] Control Center prototype displays the expected inventory.
- [ ] Release notes call out early alpha risks clearly.
- [ ] Public alpha notes are prepared from `docs/alpha-release-notes.md`.
