FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

ARG FMD2_VERSION="2.0.32.0"

LABEL \
  maintainer="mail@elry.moe"

ENV \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  WINEDEBUG="-all" \
  HOME=/config
  

RUN \
  pacman -Syu --noconfirm && \
  pacman -S --noconfirm wine wget p7zip curl git python-pyxdg inotify-tools rsync && \
  git clone https://aur.archlinux.org/yay.git /opt/yay && \
  cd /opt/yay && makepkg -si --noconfirm && \
  yay -S --noconfirm wine-mono wine-gecko && \
  curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/tags/${FMD2_VERSION} | grep "browser_download_url.*download.*fmd.*x86_64.*.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \
  7z x FMD2.7z -o/app/FMD2 && \
  rm FMD2.7z && \
  mkdir /downloads && \
  mkdir -p /app/FMD2/userdata && \
  mkdir -p /app/FMD2/downloads && \
  useradd -m -U abc

# Copy my settings preset
COPY settings.json root /

VOLUME /config
EXPOSE 3000
