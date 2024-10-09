FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

ARG FMD2_VERSION="2.0.33.0"

LABEL \
  maintainer="mail@elry.moe"

ENV \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  WINEDEBUG="-all" \
  HOME=/config
  
USER root
  
RUN \
  echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
  pacman -Syu --noconfirm && \
  pacman -Sy --noconfirm git curl wget make sudo && \
  usermod -aG sudo abc
  
USER abc

WORKDIR /home/abc

ENV GOCACHE=/home/abc/.cache/go-build
ENV GOPATH=/home/abc/go

RUN \
  mkdir -p "$GOCACHE" "$GOPATH" && \
  git clone https://aur.archlinux.org/yay.git && \
  cd yay && makepkg -si --noconfirm
  
USER root

WORKDIR /root

RUN \
  cd ~ && \
  yay -Sy --noconfirm wine wine-mono wine-gecko p7zip python-pyxdg inotify-tools rsync && \
  curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/tags/${FMD2_VERSION} | grep "browser_download_url.*download.*fmd.*x86_64.*.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \
  7z x FMD2.7z -o/app/FMD2 && \
  rm FMD2.7z && \
  mkdir /downloads && \
  mkdir -p /app/FMD2/userdata && \
  mkdir -p /app/FMD2/downloads
  
# Copy my settings preset
COPY settings.json root /

VOLUME /config
EXPOSE 3000
