# Custom Electron Header Mirror

## Purpose:
 - Allows patching electron headers(if necessary) before they're fetched by yarn
 - Electron's header distribution has been killing our builds lately by severing our connection mid-download. Kinda banking on github being more reliable 😬

## Usage
This is intended to replace the official electron header mirror.
Set the disturl when installing packages to `https://github.com/gitkraken/custom-electron-headers/raw/master`

This doesn't include all electron versions, just the ones we're using

### yarn

## Adding new header versions
probably doesn't work on windows, not sure about mac

 1. set an env var ELECTRON_VERSION to the intended version
 1. run `gen.sh`
 1. commit that