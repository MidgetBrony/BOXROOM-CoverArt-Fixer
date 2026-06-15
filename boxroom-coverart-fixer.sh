#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Missing config.conf"
  exit 1
fi

source "$CONFIG_FILE"

copied=0
skipped=0
missing=0

for gamedir in "$BOXROOM_CACHE"/*; do
  [ -d "$gamedir" ] || continue

  appid="$(basename "$gamedir")"
  boxart="$gamedir/boxart.jpg"

  if [ -f "$boxart" ]; then
    skipped=$((skipped+1))
    continue
  fi

  steamfolder="$STEAM_CACHE/$appid"

  if [ ! -d "$steamfolder" ]; then
    missing=$((missing+1))
    continue
  fi

  cover=$(find "$steamfolder" -type f -name "library_600x900.jpg" | head -n 1)

  if [ -n "$cover" ]; then
    cp "$cover" "$boxart"
    echo "[COPIED] $appid"
    copied=$((copied+1))
  else
    echo "[NO COVER] $appid"
    missing=$((missing+1))
  fi
done

echo
echo "========== SUMMARY =========="
echo "Copied : $copied"
echo "Skipped: $skipped"
echo "Missing: $missing"
echo "============================="
