#!/bin/bash

# ios
rsvg-convert icon/logo.svg -b white -h 1024 -w 1024 -f png -o icon/icon_ios.png

# android
# rsvg-convert icon/logo_mask.svg -h 1024 -w 1024 -f png -o icon/logo_mask.png
# convert icon/logo.png -matte icon/icon-mask.png -compose copy-opacity -composite icon/icon.png

# app logo
# convert icon/logo.png -resize 6.25% doc/img/logo.64.png
rsvg-convert icon/logo.svg -h 1024 -w 1024 -f png -o icon/logo.png
convert icon/logo.png -resize 50% icon/icon.512.png
rsvg-convert icon/logo.svg -h 64 -w 64 -f png -o doc/img/logo.64.png

# flutter pub pub run flutter_launcher_icons:main
