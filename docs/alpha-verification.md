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
f3999d2fa11d13ffe5f7f0b8a31396a67a17dee97e245a4a2bf6c53f3d0492c3
```

## Image Smoke Checks

Verified inside the built image:

- `pocketforge-daemon --json` returns valid daemon inventory.
- `pocketforge-daemon.service` is enabled.
- `pocketforge-firstboot.service` is enabled.
- Device profiles are installed in `/usr/share/pocketforge/device-profiles/`.
- Performance profiles are installed in `/usr/share/pocketforge/performance-profiles/`.
- Control Center prototype is installed in `/usr/share/pocketforge/control-center/`.
- Control Center desktop launcher is installed.
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
