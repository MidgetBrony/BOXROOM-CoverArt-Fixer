# BOXROOM-CoverArt-Fixer

Fixes missing cover art in BOXROOM by copying existing portrait artwork from Steam's local cache into BOXROOM's cache.

## What it does

BOXROOM stores cover art in:

%USERPROFILE%\AppData\LocalLow\NestedLoop\BOXROOM\steam_cache_v2\<AppID>\

and expects:

boxart.jpg

to exist.

Steam already stores portrait artwork for many games in:

Steam\appcache\librarycache\<AppID>\

as:

library_600x900.jpg

This script scans the BOXROOM cache and:

Checks for missing boxart.jpg files.
Copies Steam's library_600x900.jpg when available.
Does not overwrite existing custom artwork.
Does not modify Steam files.
## Usage
Download FixBoxroomCovers.ps1
Right-click the script and select Run with PowerShell
Wait for the scan to complete
Launch BOXROOM
## Notes
Make a backup if you're nervous.
Existing custom covers are preserved.
Uses artwork already stored locally by Steam.
No external downloads are performed.

### Why?

The BOXROOM demo originally included an artwork downloader, but this functionality could not be shipped in the final release. As a result, some games may appear without cover art even though Steam already has the required artwork cached locally.

This script provides a simple workaround until a more integrated solution becomes available.

### License

MIT License

### Credits

Created by MidgetBrony.
BOXROOM developed by Nested Loop.
