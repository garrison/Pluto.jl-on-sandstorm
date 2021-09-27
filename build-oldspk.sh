#!/bin/bash

set -euo pipefail

if ! [ -x "build-oldspk.sh" ]; then
    echo "This script is meant to be run from the directory holding it." >&2
    exit 1
fi

rm -rf oldspk

TMPDIR=$(mktemp -d -t pluto-sandstorm-build.XXXX)
IIDFILE=$TMPDIR/iidfile
CIDFILE=$TMPDIR/cidfile

docker build --rm=false --iidfile=$IIDFILE .
docker create --cidfile=$CIDFILE $(cat $IIDFILE)
mkdir -p oldspk
docker export $(cat $CIDFILE) | tar x -C oldspk
docker rm $(cat $CIDFILE)

rm -rf $TMPDIR
