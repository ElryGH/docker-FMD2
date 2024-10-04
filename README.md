## Description

A Dockerized FMD2 (Arch Linux with Wine) using VNC, noVNC and webSocketify to display GUI on a webpage.

How to, for people coming from the original Repo by [Banh-Canh](https://github.com/Banh-Canh):

Shut down your current Container, back up your settings, replace the compose stuff and start the container up with `--force-recreate`

## Warning
Do not change the Download path inside FMD2, we have a script to move files from wine to the output volume. (Due to wine issues)

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
      - UMASK=022
      #Time between checks for downloaded files.
      - THRESHOLD_MINUTES=5
      #If you want to download a different Format (zip or pdf), change that here too.
      - TRANSFER_FILE_TYPE=.cbz 
    ports:
      - "127.0.0.1:3000:3000"
    volumes:
      - ./fmd2:/app/FMD2/userdata
      - ./manga-downloads:/downloads
    restart: unless-stopped
```
## Credits
Originally created and maintained by [Banh-Canh](https://github.com/Banh-Canh)

## Features:
* Does not require any display, works headless
* Keeps all of FMD2 features
* Since it's docker, it works on Linux
* Make use of the fast Linuxserver arch image
* Open for suggestions

## License
[MIT](https://choosealicense.com/licenses/mit/)
