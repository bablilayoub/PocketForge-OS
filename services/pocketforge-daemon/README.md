# PocketForge Daemon

Background system service for PocketForge OS.

The current daemon is a safe early skeleton. It starts as a systemd service,
loads PocketForge device and performance profile metadata, reads DMI metadata
for device detection, and logs the profiles available on the image.

Current behavior:

- Read `/usr/share/pocketforge/device-profiles`
- Read `/usr/share/pocketforge/performance-profiles`
- Match the current device from read-only `/sys/class/dmi/id` metadata
- Log detected profile IDs and names
- Print profile inventory with `pocketforge-daemon --json`
- Refresh metadata periodically

Current JSON contract:

```json
{
  "daemon": {
    "name": "pocketforge-daemon",
    "contract_version": "0.2",
    "mode": "read-only"
  },
  "detection": {
    "system": {
      "sys_vendor": "ASUSTeK COMPUTER INC.",
      "product_name": "RC72LA",
      "product_version": "",
      "board_name": ""
    },
    "current_device": {
      "matched": true,
      "id": "rog-ally-x",
      "name": "ASUS ROG Ally X",
      "matched_on": "sys_vendor+product_name"
    }
  },
  "device_profiles": [
    {
      "id": "rog-ally-x",
      "name": "ASUS ROG Ally X"
    }
  ],
  "performance_profiles": [
    {
      "id": "balanced",
      "name": "Balanced"
    }
  ]
}
```

Future responsibilities:

- Performance profile application
- Battery modes
- Display settings
- Per-game profile application
- Communication with the Control Center and Overlay

This service is currently a project placeholder. Early alpha builds should keep
the daemon minimal until hardware-safe control paths are designed and tested.
