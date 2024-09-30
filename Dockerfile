FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine320

ARG FMD2_VERSION="2.0.32.0"

LABEL \
  maintainer="mail@elry.moe"

ENV \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  WINEDEBUG="-all" \
  HOME=/config
  
COPY repositories /etc/apk/repositories
COPY resolv.conf /etc/resolv.conf

# Install required packages
RUN apk update && \
    apk add --no-cache \
      bash \
      curl \
      git \
      inotify-tools \
      p7zip \
      jq \
      python3 \
      rsync \
      wine

# Download and extract FMD2
RUN curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/tags/${FMD2_VERSION} | \
    jq -r '.assets[] | select(.name | contains("x86_64-win64")).browser_download_url' > download_url.txt && \
    curl -L -o FMD2.7z $(cat download_url.txt) && \
    7z x FMD2.7z -o/app/FMD2 && \
    rm FMD2.7z && \
    mkdir -p /downloads && \
    mkdir -p /app/FMD2/userdata && \
    mkdir -p /app/FMD2/downloads

# Copy settings preset
COPY settings.json root /

VOLUME /config
EXPOSE 3000
