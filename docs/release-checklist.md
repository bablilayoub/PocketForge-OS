# Alpha Release Checklist

Use this before tagging or announcing an alpha image.

## Before Build

```bash
scripts/check-local
git status --short --branch
```

Confirm the working tree is clean, then manually run:

- `Validate project files`
- `Build container image`

## After Build

Confirm the image exists:

```bash
skopeo inspect docker://ghcr.io/bablilayoub/pocketforge-os:latest
```

If `skopeo` is unavailable, check the GHCR package page in GitHub.

## VM Smoke Test

On a machine with rootful Podman, virtualization support, and enough disk space:

```bash
just rebuild-qcow2
just run-vm-qcow2
```

Inside the image, check:

```bash
systemctl status pocketforge-daemon.service
systemctl status pocketforge-firstboot.service
journalctl -u pocketforge-daemon --no-pager
```

## Release Notes

Every alpha release must say:

- PocketForge OS is early alpha.
- Do not install on a main device.
- Keep recovery media ready.
- Custom handheld controls are metadata-only/read-only for now.
- No TDP, fan, firmware, or embedded-controller writes are included yet.
