# LTS Node as of 202006 is version 12:
FROM node:12-alpine 

# Build and runtime requirements for native node libraries:
# Busybox's commands are a bit too bare-bones:
# procps for `ps -o lstart`
# coreutils for `df -kPl`
# util-linux (which should be there already) for `renice` and `lsblk`
# Perl is for exiftool.
# bash is just for running the test harness, and is not in the final Docker image.
# musl-locales for `locale`

# https://pkgs.alpinelinux.org/contents

RUN apk update ;\
  apk upgrade ;\
  apk add --no-cache build-base git lcms2-dev libjpeg-turbo-dev python3-dev procps coreutils util-linux ffmpeg perl sqlite libjpeg-turbo-utils bash ;\
  apk add --no-cache musl-locales --repository http://dl-3.alpinelinux.org/alpine/v3.12/community

RUN wget https://photostructure.com/src/dcraw.c ;\
  gcc -o dcraw -O4 dcraw.c -lm -DNODEPS ;\
  mkdir -p /ps/app/bin ;\
  mv dcraw /ps/app/bin ;\
  rm dcraw.c
