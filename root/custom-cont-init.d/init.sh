#!/bin/bash
if [ ! -f '/app/FMD2/userdata/settings.json' ]; then cp /settings.json /app/FMD2/userdata/settings.json; fi
mkdir -p /app/FMD2/src
git clone --single-branch --depth=1 https://github.com/dazedcat19/FMD2.git /app/FMD2/src
cp /app/FMD2/src/lua /app/FMD2 -R
mkdir -p /tmp/.X11-unix
sudo chmod 1777 /tmp/.X11-unix -R
sudo chown abc:abc /app -R
sudo chown abc:abc /config -R
sudo find /downloads -type d -exec chown abc:abc {} \;
sudo chmod +x /usr/local/bin/sync_dir
