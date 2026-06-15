# BOXROOM-CoverArt-Fixer

Fixes missing cover art in BOXROOM by copying existing portrait artwork from Steam's local cache into BOXROOM's cache.

---

## What it does

BOXROOM stores cover art in its cache and expects each game folder to contain:

```
boxart.jpg
```

Steam already stores portrait artwork for many games as:

```
library_600x900.jpg
```

This utility scans your BOXROOM cache and:

- Checks for missing `boxart.jpg` files.
- Copies Steam's `library_600x900.jpg` when available.
- Never overwrites existing custom artwork.
- Never modifies Steam files.
- Uses artwork already stored on your computer.

---

# Windows

BOXROOM cache:

```
%USERPROFILE%\AppData\LocalLow\NestedLoop\BOXROOM\steam_cache_v2\
```

Steam cache:

```
Steam\appcache\librarycache\
```

## Usage

1. Download `FixBoxroomCovers.ps1`
2. Right-click the script and choose **Run with PowerShell**
3. Wait for the scan to complete.
4. Launch BOXROOM.

---

# Linux

A Bash version is also included.

Unlike Windows, Steam and Unity data locations can vary depending on Distributions, Steam package, Custom Steam installations

Because of this, the Linux version uses a configuration file.

## Configuration

Edit:

```
config.conf
```

Example:

```bash
# Steam cache
STEAM_CACHE="$HOME/.steam/steam/appcache/librarycache"

# BOXROOM cache
BOXROOM_CACHE="$HOME/.config/unity3d/NestedLoop/BOXROOM/steam_cache_v2"
```

Update these paths if your installation differs.

## Usage

Make the script executable:

```bash
chmod +x boxroom-coverart-fixer.sh
```

Run:

```bash
./boxroom-coverart-fixer.sh
```

---

## Notes

- Existing custom covers are preserved.
- No external downloads are performed.
- Steam artwork is never modified.
- Missing covers are copied only once.
- Safe to run multiple times.

---

## Why?

The BOXROOM demo originally included an artwork downloader, but this functionality could not be shipped in the final release.

As a result, some games may appear without cover art even though Steam already has the required artwork cached locally.

This utility provides a simple workaround until a more integrated solution becomes available.

---

## Included Files

### Windows

```
FixBoxroomCovers.ps1
```

### Linux

```
boxroom-coverart-fixer.sh
config.conf
```

---

## License

MIT License

---

## Credits

Created by **MidgetBrony**

BOXROOM developed by **Nested Loop**.
