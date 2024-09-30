## Description

A Dockerized FMD2 (Apline Linux with Wine) using VNC, noVNC and webSocketify to display GUI on a webpage.

[![Docker Image](https://img.shields.io/docker/v/elrydocker/fmd2?label=docker%20image&sort=semver)](https://hub.docker.com/repository/docker/elrydocker/fmd2/general)

## Docker Compose
```yaml
---
services:
  fmd2:
    image: elrydocker/fmd2:latest
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
      - UMASK=022 #optional
      - THRESHOLD_MINUTES=5
      - TRANSFER_FILE_TYPE=.cbz
    ports:
      - "127.0.0.1:3000:3000"
    volumes:
      - ./fmd2/userdata:/app/FMD2/userdata
      - ./manga-downloads:/downloads
    restart: unless-stopped
```
## Credits
Originally created and maintained by [Banh-Canh](https://github.com/Banh-Canh)

## Features:
* Does not require any display, works headless
* Keeps all of FMD2 features
* Since it's docker, it works on Linux
* Make use of the fast Linuxserver alpine image
* Open for suggestions

## License
[MIT](https://choosealicense.com/licenses/mit/)
