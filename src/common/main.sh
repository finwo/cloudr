#!/bin/bash

# Exit on failures
set -e

# Ensure we're running as root
if [ "$EUID" -ne 0 ]; then
  echo "Root permissions are required for this installer to work" >&2
  exit 1
fi

{{>install-service.sh}}

# Install main binary
mkdir -p /usr/sbin
base64 -d <<EOF > /usr/sbin/cloudr
{{>runner.sh.base64}}
EOF
chmod +x /usr/sbin/cloudr

{{>enable-service.sh}}
