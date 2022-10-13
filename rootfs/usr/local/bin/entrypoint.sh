#!/usr/bin/env sh
set -euo pipefail


# Default qBittorrent config
if [[ ! -f /config/tinyproxy.conf ]]; then
    cp /etc/default/tinyproxy.conf /config/tinyproxy.conf
fi

exec "$@"
