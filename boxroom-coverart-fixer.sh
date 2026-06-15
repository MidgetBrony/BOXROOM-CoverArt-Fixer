#!/usr/bin/env bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Missing config.conf"
  exit 1
fi

source "$CONFIG_FILE"
# cache .conf check
if [ ! -d "${BOXROOM_CACHE:-}" ]; then
  echo "Error: BOXROOM_CACHE directory not found. Check your config.conf."
  exit 1
fi

if [ ! -d "${STEAM_CACHE:-}" ]; then
  echo "Error: STEAM_CACHE directory not found. Check your config.conf."
  exit 1
fi

copied=0
downloaded=0
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

  # Try Steam's local cache first
  cover="$STEAM_CACHE/${appid}_library_600x900.jpg"

  if [ -f "$cover" ]; then
    cp "$cover" "$boxart"
    echo "[COPIED] $appid"
    copied=$((copied+1))
  else
    # If not cached locally, download it
    cdn_url="https://steamcdn-a.akamaihd.net/steam/apps/${appid}/library_600x900.jpg"

    if curl -s -f "$cdn_url" -o "$boxart"; then
      echo "[DOWNLOADED] $appid"
      downloaded=$((downloaded+1))
    else
      echo "[MISSING] $appid (Not in cache, and failed to download)"
      missing=$((missing+1))
      rm -f "$boxart"
    fi
  fi
done

echo
echo "========== SUMMARY =========="
echo "Copied     : $copied"
echo "Downloaded : $downloaded"
echo "Skipped    : $skipped"
echo "Missing    : $missing"
echo "============================="
