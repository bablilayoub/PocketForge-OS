# Alpha Verification Log

Latest local verification: 2026-05-14

## Local Container Build

Command:

```bash
podman build --platform linux/amd64 --pull=newer --tag pocketforge-os:alpha-test .
```

Result:

- Build completed successfully.
- `bootc container lint` passed with warnings only.
- Local image tag: `pocketforge-os:alpha-test`
- Image architecture: `amd64`

Image ID:

```txt
5a4acf538f66c53ee867f6b50b0af420958a2da788371066ba2520a9afb00cf2
```

## Image Smoke Checks

Verified inside the built image:

- `pocketforge-daemon --json` returns valid daemon inventory.
- `pocketforge-daemon.service` is enabled.
- `pocketforge-firstboot.service` is enabled.
- Device profiles are installed in `/usr/share/pocketforge/device-profiles/`.
- Performance profiles are installed in `/usr/share/pocketforge/performance-profiles/`.
- Firstboot script runs successfully.
- Steam, Gamescope, MangoHud, GameMode, Fastfetch, and btop are installed.

## Remaining Alpha Gates

- Manual GitHub `Validate project files` workflow.
- Manual GitHub `Build container image` workflow.
- VM boot to KDE Plasma.
- Hardware smoke test on spare or recoverable handheld hardware.
