# PocketForge OS

**PocketForge OS** is an open-source Fedora Atomic-based gaming operating system built for PC gaming handhelds.

It is designed for devices like the ASUS ROG Ally, ROG Ally X, Lenovo Legion Go, Steam Deck, and other x86 handheld gaming PCs.

PocketForge OS focuses on a console-like experience, reliable atomic updates, rollback safety, gaming performance, and a beautiful handheld-first user experience.

---

## Goals

- Fedora Atomic / Universal Blue base
- KDE Plasma desktop mode
- Steam and Gamescope gaming support
- Handheld-first UX
- Device profiles for popular handhelds
- Performance and battery profiles
- Atomic updates with rollback support
- Future custom PocketForge Control Center
- Open-source and community-driven

---

## PocketForge Stack

PocketForge OS does not rely on HHD as its handheld control layer.

Instead, the project aims to build its own native handheld stack:

- **PocketForge Daemon** — background system service for device control
- **PocketForge Control Center** — graphical app for handheld settings
- **PocketForge Overlay** — in-game quick settings overlay
- **Device Profiles** — YAML-based hardware definitions
- **Performance Profiles** — per-mode and per-game tuning

The goal is to provide a cleaner, more polished, and more integrated handheld experience.

---

## Current Status

PocketForge OS is currently in **early alpha development**.

Do not install it on your main device yet unless you know how to recover, rollback, or reinstall your system.

---

## Base

PocketForge OS currently uses:

```txt
Universal Blue Kinoite
Fedora Atomic
KDE Plasma
bootc
rpm-ostree
```

---

## Included Early Packages

The current image includes basic gaming and system tools such as:

```txt
Steam
Gamescope
MangoHud
GameMode
Fastfetch
btop
htop
tmux
git
curl
wget
```

More handheld-specific tools will be added later.

---

## Target Devices

Initial target devices:

```txt
ASUS ROG Ally X
ASUS ROG Ally
Lenovo Legion Go
Steam Deck
```

More devices will be added as the project matures.

---

## Image

The container image is published to GitHub Container Registry:

```txt
ghcr.io/bablilayoub/pocketforge-os:latest
```

---

## Roadmap

### Phase 1 — Base Image

- [x] Create Universal Blue image
- [x] Use Kinoite base
- [x] Add branding files
- [x] Add device profile structure
- [x] Publish image to GHCR

### Phase 2 — Handheld Foundation

- [ ] Build PocketForge Daemon
- [ ] Build PocketForge Control Center
- [ ] Build PocketForge Overlay
- [ ] Add device detection
- [ ] Add performance profiles
- [ ] Add TDP and battery controls
- [ ] Add display refresh-rate controls
- [ ] Add Steam gaming session
- [ ] Add better Gamescope configuration
- [ ] Add Flatpak app setup

### Phase 3 — PocketForge Control Center

- [ ] Build Tauri + React app
- [ ] Show device info
- [ ] Show battery and performance state
- [ ] Add performance profiles
- [ ] Add per-device settings
- [ ] Add update UI

### Phase 4 — Installer

- [ ] Generate installable ISO
- [ ] Add first-boot wizard
- [ ] Add recovery instructions
- [ ] Add public alpha release

---

## Warning

This project is experimental.

Use at your own risk.
