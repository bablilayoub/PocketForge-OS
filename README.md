# PocketForge OS

**PocketForge OS** is an open-source Fedora Atomic-based gaming operating system built for PC gaming handhelds.

It is designed for devices like the ASUS ROG Ally, ASUS ROG Ally X, Lenovo Legion Go, Steam Deck, and other x86 handheld gaming PCs.

PocketForge OS builds on the Fedora Atomic model and the Universal Blue Kinoite base to provide a KDE Plasma handheld gaming system with reliable image updates, rollback safety, Steam support, Gamescope sessions, MangoHud overlays, GameMode integration, and a native PocketForge handheld stack.

---

## Early Alpha Warning

PocketForge OS is currently in **early alpha development**.

Do not install it on your main device yet unless you are comfortable recovering, rolling back, or reinstalling a Fedora Atomic system.

The project structure is being prepared now; the handheld stack is not production-ready.

---

## Goals

- Fedora Atomic / Universal Blue base
- KDE Plasma desktop mode
- Steam, Gamescope, MangoHud, and GameMode gaming support
- Handheld-first UX
- Device profiles for popular handhelds
- Performance and battery profiles
- Atomic updates and rollback support
- Native PocketForge control services and apps
- Open-source and community-driven

---

## PocketForge Stack

PocketForge OS is building its own native handheld stack:

- **PocketForge Daemon** — background system service for device control
- **PocketForge Control Center** — graphical app for handheld settings
- **PocketForge Overlay** — in-game quick settings overlay
- **Device Profiles** — YAML-based hardware definitions
- **Performance Profiles** — per-mode and per-game tuning

The goal is to provide a clean, polished, and integrated handheld experience while keeping early images simple and stable.

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

During early alpha development, full image builds are intentionally manual or
scheduled instead of running on every commit. Run `scripts/check-local` before
committing active work.

Testing guidance is available in `docs/testing.md`.
Alpha boot testing is documented in `docs/alpha-boot-runbook.md`.
Alpha readiness is tracked in `docs/alpha-readiness.md`.
Hardware support status is documented in `docs/hardware-support.md`.
Draft alpha release notes live in `docs/alpha-release-notes.md`.

---

## Roadmap

### Phase 1 — Base Image

- [x] Create Universal Blue image
- [x] Use Kinoite base
- [x] Add branding files
- [x] Add device profile structure
- [x] Publish image to GHCR

### Phase 2 — Handheld Foundation

- [x] Build PocketForge Daemon skeleton
- [x] Build PocketForge Control Center prototype
- [ ] Build PocketForge Overlay
- [x] Add metadata-only device profiles
- [x] Add metadata-only performance profiles
- [x] Add read-only device detection
- [ ] Add Steam gaming session
- [ ] Add better Gamescope configuration
- [ ] Add Flatpak app setup

### Phase 3 — PocketForge Control Center

- [ ] Build Tauri + React app
- [ ] Show device info
- [x] Show profile inventory
- [ ] Show battery and runtime state
- [x] Add read-only performance profiles
- [ ] Add per-device settings
- [ ] Add update UI

### Phase 4 — Installer

- [ ] Generate installable ISO
- [ ] Add first-boot wizard
- [ ] Add recovery instructions
- [ ] Add public alpha release

---

## Warning

PocketForge OS is experimental early alpha software. Use it at your own risk, and keep recovery media available when testing on real hardware.
