# Deprecation (Archive) Warning

I, along with many others, [had](https://github.com/Banh-Canh/docker-FMD2/issues/22) & [have](https://github.com/ElryGH/docker-FMD2/issues/5) ongoing permission issues and 0Kbps speeds with the Dockerized version (all thanks to WINE).  
Banh finally had enough and passed the repository to me. I made every attempt to fix these WINE-related issues, but it didn't work out...  
As of today, I am officially giving up on this unfortunate, seemingly unfixable mess that is WINE on Docker and archiving this project.  
I'll be moving to a Windows Nano VPS, where everything runs without any of these problems.</br>
I'm sorry I couldn't fix it, <ins>but WINE had other plans</ins>.

## Description

A (slightly faster) Dockerized FMD2 (Arch Linux) using VNC, noVNC and webSocketify to display GUI on a webpage.

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
