#!/usr/bin/sh

export DEBIAN_FRONTEND=noninteractive
apt update
apt install -y \
    python3-apt \
    python3-distro-info \
    python3-launchpadlib \


set -xe

RETRACER_DIR="$(dirname "$0")"
BASE_DIR="$(dirname "$(dirname "$RETRACER_DIR")")"
CRASHES_DIR="/tmp/crashes"

# Get the test crashes
mkdir -p "$CRASHES_DIR"
cd "$CRASHES_DIR"
"$RETRACER_DIR"/fetch-test-crashes noble amd64
cd -

PYTHONPATH="$BASE_DIR" python3 "$BASE_DIR"/bin/apport-retrace -S "$RETRACER_DIR"/config -C /srv/apport-retrace --verbose --gdb-sandbox --stdout "$CRASHES_DIR"/test-crashes/noble/amd64/_usr_bin_xeyes.2001.crash
