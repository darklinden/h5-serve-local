#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
PROJECT_DIR="$(realpath "${BASEDIR}")"

cd $PROJECT_DIR || exit

echo "Load environment variables ..."

if [ -f $PROJECT_DIR/.env ]; then
    echo "Loading environment variables from $PROJECT_DIR/.env ..."
    set -a
    source $PROJECT_DIR/.env
    set +a
fi

if [ -z "$CF_Token" ]; then
    echo "CF_Token is not set. Please set CF_Token in .env file."
    exit 1
fi

if [ -z "$CF_Zone_ID" ]; then
    echo "CF_Zone_ID is not set. Please set CF_Zone_ID in .env file."
    exit 1
fi

ACME_DIR="$PROJECT_DIR/acme"

docker run -it \
    -v "$ACME_DIR":/acme.sh \
    neilpang/acme.sh --set-default-ca --server letsencrypt

docker run -it \
    -v "$ACME_DIR":/acme.sh \
    -e CF_Token=$CF_Token \
    -e CF_Zone_ID=$CF_Zone_ID \
    neilpang/acme.sh --issue --dns dns_cf -d local.darklinden.site

docker run -it \
    -v "$ACME_DIR":/acme.sh \
    -e CF_Token=$CF_Token \
    -e CF_Zone_ID=$CF_Zone_ID \
    neilpang/acme.sh --issue --dns dns_cf -d local-ws.darklinden.site

cp -rf $ACME_DIR/local.darklinden.site_ecc/fullchain.cer $PROJECT_DIR/ssl/local.darklinden.site.fullchain.cer
cp -rf $ACME_DIR/local.darklinden.site_ecc/local.darklinden.site.key $PROJECT_DIR/ssl/local.darklinden.site.key

cp -rf $ACME_DIR/local-ws.darklinden.site_ecc/fullchain.cer $PROJECT_DIR/ssl/local-ws.darklinden.site.fullchain.cer
cp -rf $ACME_DIR/local-ws.darklinden.site_ecc/local-ws.darklinden.site.key $PROJECT_DIR/ssl/local-ws.darklinden.site.key
