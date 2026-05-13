# PocketForge Performance Profiles

Shared PocketForge OS performance profile definitions will live here.

This directory is intentionally conservative for now. Early alpha builds should
prefer simple, declarative profile metadata before adding low-level power, fan,
or firmware controls.

Profiles are validated against `schema.json`. Current profiles describe intent
only; the PocketForge Daemon will decide how to apply them once safe hardware
interfaces are available.
