#!/usr/bin/env sh
set -euo pipefail


# Default qBittorrent config
if [[ ! -f /config/tinyproxy.conf ]]; then
    cp /default/tinyproxy.conf /config/tinyproxy.conf
fi

exec "$@"
