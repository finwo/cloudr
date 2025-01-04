#!/bin/sh

{{>install-dependencies.sh}}

# Handle json meta
META=$(cat /sys/class/dmi/id/chassis_asset_tag)
if [ ! -z "${META}" ]; then
  if printf "%s" "${META}" | jq -e . 2>/dev/null; then
    # Given hostname = use it
    if $(printf "%s" "${META}" | jq -r 'has("hostname")'); then
      printf "%s" "${META}" | jq -r .hostname > /etc/hostname
      hostname $(cat /etc/hostname)
    fi
  fi
fi
