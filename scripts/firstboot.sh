#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="/var/lib/pocketforge-os"
STATE_FILE="$STATE_DIR/firstboot-complete"

mkdir -p "$STATE_DIR"

if [ ! -f "$STATE_FILE" ]; then
  echo "Welcome to PocketForge OS"
  echo "First boot setup completed at $(date)" > "$STATE_FILE"
fi
