# LTS Node as of 202006 is version 12:
FROM node:14-alpine 

# Build and runtime requirements for native node libraries:
# Busybox's commands are a bit too bare-bones:
# bash is just for running the test harness, and is not in the final Docker image.
# coreutils for `df -kPl`
# perl is for exiftool.
# procps for `ps -o lstart`
# util-linux (which should be there already) for `renice` and `lsblk`
# musl-locales for `locale`

# https://pkgs.alpinelinux.org/contents

RUN apk update ;\
  apk upgrade ;\
  apk add --no-cache \
  bash \
  build-base \
  coreutils \
  ffmpeg \
  git \
  lcms2-dev \
  libjpeg-turbo-dev \
  libjpeg-turbo-utils \
  ncurses \
  perl \
  procps \
  python3-dev \
  sqlite \
  util-linux; \
  apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.12/community \
  musl-locales

RUN wget https://photostructure.com/src/dcraw.c ;\
  gcc -o dcraw -O4 dcraw.c -lm -DNODEPS ;\
  mkdir -p /ps/app/bin ;\
  mv dcraw /ps/app/bin ;\
  rm dcraw.c
