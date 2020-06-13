# LTS Node as of 202006 is version 12:
FROM node:12-alpine 

# Build and runtime requirements for native node libraries:
# Busybox's commands are a bit too bare-bones:
# procps for `ps -o lstart`
# coreutils for `df -kPl`
# util-linux (which should be there already) for `renice` and `lsblk`
# Perl is for exiftool.
# musl-locales for `locale`

# https://pkgs.alpinelinux.org/contents

RUN apk update ;\
  apk upgrade ;\
  apk add build-base lcms2-dev libjpeg-turbo-dev python3-dev procps coreutils util-linux ffmpeg perl sqlite libjpeg-turbo-utils musl-locales \
  --update-cache --repository http://dl-3.alpinelinux.org/alpine/v3.12/community

RUN wget https://photostructure.com/src/dcraw.c ;\
  gcc -o dcraw -O4 dcraw.c -lm -DNODEPS ;\
  mkdir -p /ps/app/tools ;\
  cp dcraw /ps/app/tools
