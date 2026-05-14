# PocketForge OS Alpha Release Notes Draft

Use this draft for the first public alpha announcement after the image passes
the alpha boot runbook.

## Status

PocketForge OS is early alpha software. It is intended for developers and
careful testers with spare or recoverable handheld hardware.

Do not install this alpha on a main device. Keep recovery media ready and be
prepared to reinstall or roll back.

## What This Alpha Is

PocketForge OS is an open-source Fedora Atomic-based gaming operating system
built for PC gaming handhelds. This alpha uses the Universal Blue Kinoite base,
KDE Plasma, bootc, and rpm-ostree.

The image includes:

- KDE Plasma desktop.
- Steam.
- Gamescope.
- MangoHud.
- GameMode.
- PocketForge Daemon in read-only metadata mode.
- PocketForge Control Center prototype.
- Device profile metadata.
- Performance profile metadata.

## Target Test Devices

Initial metadata exists for:

- ASUS ROG Ally.
- ASUS ROG Ally X.
- Lenovo Legion Go.
- Steam Deck LCD.
- Steam Deck OLED.

These are target test devices, not guaranteed supported devices yet.

## What Is Not Included Yet

This alpha intentionally does not include:

- TDP control.
- Fan control.
- Firmware writes.
- Embedded-controller writes.
- Automatic device-specific tuning.
- Production installer polish.
- Production recovery UX.
- Stable gaming-session switching.

## Before Testing

Before installing on hardware:

- Read `docs/alpha-boot-runbook.md`.
- Test the image in a VM first.
- Use spare or recoverable hardware.
- Back up any important data.
- Prepare vendor recovery media or a known-good Linux installer.
- Confirm how to reach the device boot menu.
- Keep an external keyboard available.

## Minimum Expected Alpha Behavior

A successful first alpha test means:

- The image boots to KDE Plasma.
- Networking works.
- Steam opens.
- Gamescope, MangoHud, and GameMode are installed.
- PocketForge Control Center opens.
- PocketForge Daemon loads device and performance profile metadata.
- No low-level handheld control writes are attempted.
- Reboot works.
- Recovery or reinstall path is confirmed.

## Reporting Results

When reporting a test result, include:

- Device model.
- Image tag or digest.
- Install method.
- Whether KDE Plasma booted.
- Whether networking worked.
- Whether Steam opened.
- Whether PocketForge Control Center opened.
- Output from `systemctl --failed`.
- Output from `journalctl -u pocketforge-daemon --no-pager`.
- Any recovery steps needed.

## Known Alpha Risks

Expect rough edges. The handheld-specific stack is still being built and is
metadata-only for this alpha. Controller behavior, session switching, power
profiles, and device-specific tuning are not production-ready.
