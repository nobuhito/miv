#!/bin/bash
rsvg-convert icon/logo.svg -h 1024 -w 1024 -f png -o icon/logo.png
rsvg-convert icon/logo.svg -h 64 -w 64 -f png -o doc/img/logo.64.png
# convert icon/logo.png -matte icon/icon-mask.png -compose copy-opacity -composite icon/icon.png
convert icon/logo.png -resize 50% icon/icon.512.png

# flutter pub pub run flutter_launcher_icons:main
