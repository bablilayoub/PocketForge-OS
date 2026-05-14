# Profile Schema Notes

PocketForge profiles are intentionally metadata-only during early alpha.

## Device Profiles

Device profiles live in `shared/device-profiles/` and must match
`shared/device-profiles/schema.json`.

Required fields:

- `id`: lowercase kebab-case identifier
- `name`: user-visible device name
- `detection.dmi`: read-only DMI match metadata
- `display.resolution`: native resolution in `WIDTHxHEIGHT` format
- `display.refresh_rates`: supported refresh-rate metadata
- `controls`: boolean feature map
- `launchers`: boolean launcher support map

DMI detection keys are substring matches against `/sys/class/dmi/id` values.
Use conservative values such as product codes to avoid matching the wrong
handheld model.

## Performance Profiles

Performance profiles live in `shared/performance-profiles/` and must match
`shared/performance-profiles/schema.json`.

Current profiles describe intent only. They do not write hardware state.

## Safety Boundary

Profiles must not contain low-level control values until PocketForge has a
tested hardware safety model. Keep TDP, fan curves, firmware writes, and
embedded-controller operations out of profile metadata for alpha.
