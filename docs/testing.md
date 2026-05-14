# Testing PocketForge OS

PocketForge OS is early alpha. Prefer layered testing before installing on real
hardware.

## Fast Local Checks

Run this before commits:

```bash
scripts/check-local
```

This validates metadata, schemas, shell scripts, daemon JSON, and the current
read-only Control Center sample.

For a quick alpha milestone summary:

```bash
scripts/alpha-status
```

## Daemon Testing

Run the daemon once against the repository metadata:

```bash
POCKETFORGE_DEVICE_PROFILE_DIR="$PWD/shared/device-profiles" \
POCKETFORGE_PERFORMANCE_PROFILE_DIR="$PWD/shared/performance-profiles" \
scripts/pocketforge-daemon --once
```

Check the JSON contract:

```bash
POCKETFORGE_DEVICE_PROFILE_DIR="$PWD/shared/device-profiles" \
POCKETFORGE_PERFORMANCE_PROFILE_DIR="$PWD/shared/performance-profiles" \
scripts/pocketforge-daemon --json | jq .
```

## Control Center Prototype

Serve the static prototype:

```bash
python3 -m http.server 8080 --directory apps/pocketforge-control-center
```

Then open:

```txt
http://localhost:8080
```

## Image Testing

Full image builds are manual during early development.

Use GitHub Actions:

- Run `Validate project files` before a larger merge.
- Run `Build container image` when image layout, packages, services, or
  Containerfile behavior changes.
- Run `Build disk images` only when installer or VM image work changes.

For local image work, install Podman and use:

```bash
podman build --platform linux/amd64 --pull=newer --tag pocketforge-os:alpha-test .
```

For VM or ISO work, use the Justfile helpers only on a machine with enough disk
space and virtualization support:

```bash
just rebuild-qcow2
just run-vm-qcow2
```

## Hardware Testing

Do not install PocketForge OS on a main device yet. Use spare hardware or a
replaceable drive, keep recovery media ready, and confirm rollback or reinstall
steps before testing.
