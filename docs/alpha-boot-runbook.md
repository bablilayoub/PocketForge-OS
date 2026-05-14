# Alpha Boot Test Runbook

Use this runbook when turning a built PocketForge OS image into an alpha boot
candidate. The goal is to prove that the image boots, reaches KDE Plasma, and
loads the read-only PocketForge stack before testing on handheld hardware.

PocketForge OS is early alpha. Do not use a main device for hardware testing.
Keep recovery media ready and avoid testing any TDP, fan, firmware, or
embedded-controller writes.

## 1. Preflight

Run these checks before building or publishing a candidate:

```bash
scripts/check-local
scripts/alpha-status
git status --short --branch
```

The working tree should be clean before triggering release-style workflows.

## 2. Manual GitHub Workflows

Run these workflows from the GitHub Actions tab:

- `Validate project files`
- `Build container image`

After `Build container image` passes, confirm the image can be inspected:

```bash
skopeo inspect docker://ghcr.io/bablilayoub/pocketforge-os:latest
```

If `skopeo` is unavailable, use the GHCR package page and confirm the latest
tag was updated by the workflow run.

## 3. Disk Image Build

Build a bootable disk image only after the container image passes.

Preferred path:

- Run the manual `Build disk images` GitHub workflow.
- Use `amd64` for the first alpha handheld target.
- Leave S3 upload disabled unless publishing a public artifact.
- Download the workflow artifact when it completes.

Local Linux path:

```bash
just rebuild-qcow2
```

This requires rootful Podman, enough disk space, and virtualization support.
Rootless Podman cannot generate the QCOW2/ISO artifacts with
bootc-image-builder.

## 4. VM Boot Test

Boot the generated image before using real hardware.

For a locally generated QCOW2:

```bash
just run-vm-qcow2
```

The VM passes alpha boot smoke when:

- KDE Plasma reaches the desktop.
- Network is available.
- Steam launches or reaches its login/update flow.
- PocketForge Gaming Mode starts Steam Big Picture through Gamescope.
- The PocketForge Control Center launcher is visible.
- The PocketForge Control Center opens the installed prototype.
- No systemd unit is failed after first boot.

Inside the VM, run:

```bash
systemctl --failed
systemctl status pocketforge-daemon.service
systemctl status pocketforge-firstboot.service
journalctl -u pocketforge-daemon --no-pager
test -f /usr/share/pocketforge/control-center/index.html
test -f /usr/share/applications/pocketforge-control-center.desktop
```

Expected daemon log behavior:

- Device profiles are loaded.
- Performance profiles are loaded.
- The daemon remains read-only.
- No TDP, fan, firmware, or embedded-controller writes are attempted.

## 5. Hardware Smoke Test

Only test on spare or recoverable hardware.

Before installing:

- Back up important data.
- Prepare vendor recovery media or a known-good Linux installer.
- Confirm BIOS boot menu access.
- Confirm external keyboard access if the handheld controls do not work.
- Prefer a replaceable SSD or external test drive for the first pass.

Minimum hardware pass:

- Device boots to KDE Plasma.
- Display, touch, keyboard, or external input can unlock/use the desktop.
- Wi-Fi connects.
- Steam opens.
- Gamescope is installed.
- MangoHud is installed.
- GameMode is installed.
- PocketForge Control Center opens.
- `pocketforge-daemon.service` is active or exited cleanly in read-only mode.
- Reboot works.
- Rollback or reinstall path is confirmed.

Stop testing and recover the device if boot loops, storage errors, thermal
issues, or firmware warnings appear.

## 6. Record Results

Update `docs/alpha-verification.md` after each serious candidate.

Record:

- Date.
- Image tag or digest.
- Disk artifact type.
- VM result.
- Hardware model, if tested.
- Working features.
- Broken features.
- Recovery notes.

Do not announce an alpha until the release checklist and this boot runbook both
pass for at least one VM boot and one safe hardware smoke test.
