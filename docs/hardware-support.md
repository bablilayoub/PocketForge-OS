# Hardware Support Matrix

PocketForge OS alpha support is metadata-only. A listed device means the repo
has a validated profile that the daemon and Control Center can display. It does
not mean device-specific controls are implemented.

| Device | Profile ID | Status | Notes |
| --- | --- | --- | --- |
| ASUS ROG Ally | `rog-ally` | Metadata ready | No hardware writes |
| ASUS ROG Ally X | `rog-ally-x` | Metadata ready | No hardware writes |
| Lenovo Legion Go | `legion-go` | Metadata ready | No hardware writes |
| Steam Deck LCD | `steam-deck-lcd` | Metadata ready | No hardware writes |
| Steam Deck OLED | `steam-deck-oled` | Metadata ready | No hardware writes |

## Alpha Meaning

For alpha, PocketForge can identify and present profile metadata. The custom
stack does not yet apply device tuning, power limits, fan curves, controller
quirks, or firmware settings.

## Adding Devices

Add new profiles in `shared/device-profiles/`, then run:

```bash
scripts/sync-control-center-sample
scripts/check-local
```
