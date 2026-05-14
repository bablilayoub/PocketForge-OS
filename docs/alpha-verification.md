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
8b2915e7904e54f817ecff8c5374a37eda0a6b3661759470bb7553a60b77d38e
```

## Image Smoke Checks

Verified inside the built image:

- `pocketforge-daemon --json` returns valid daemon inventory.
- Read-only DMI detection matches known profile metadata with override values.
- `pocketforge-daemon.service` is enabled.
- `pocketforge-firstboot.service` is enabled.
- Device profiles are installed in `/usr/share/pocketforge/device-profiles/`.
- Performance profiles are installed in `/usr/share/pocketforge/performance-profiles/`.
- Control Center prototype is installed in `/usr/share/pocketforge/control-center/`.
- Control Center desktop launcher is installed.
- PocketForge Gaming Mode session is installed.
- Firstboot script runs successfully.
- Steam, Gamescope, MangoHud, GameMode, Fastfetch, and btop are installed.

## Remaining Alpha Gates

- Manual GitHub `Validate project files` workflow.
- Manual GitHub `Build container image` workflow.
- QCOW2 generation in a rootful Podman environment.
- VM boot to KDE Plasma.
- Hardware smoke test on spare or recoverable handheld hardware.

## Known Local Limitation

QCOW2 generation was attempted locally with bootc-image-builder, but the local
Podman environment is rootless. bootc-image-builder requires rootful Podman for
disk image generation, so VM artifact testing must run on a rootful Linux build
host or through the manual GitHub disk-image workflow.
