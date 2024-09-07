#!/usr/bin/env bash

if [ -z "$1" ]; then
    WORK_DIR=$(pwd)
else
    WORK_DIR=$(realpath "$1")
fi

echo "WORK_DIR: $WORK_DIR"

# on MacOS open chrome with specific url
# open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome https://local.darklinden.site

docker run -it --rm \
    -v $WORK_DIR:/usr/share/nginx/html \
    -p 80:80 \
    -p 443:443 \
    darklinden/h5-serve
