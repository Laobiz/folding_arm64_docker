# folding_arm64_docker
A simple docker container for "Folding at home" arm64

docker-compose:
```
---
version: "3"
services:
  foldingathome:
    image: laobiz/folding-arm
    container_name: foldingathome
    volumes:
      - ./fah:/fah
    ports:
      - 7396:7396
    restart: unless-stopped
```
