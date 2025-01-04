#!/bin/sh

# Detect target
ARCH=$(uname -m)
DIST=unknown
if [ -f /etc/os-release ]; then
  DIST=$(sed </etc/os-release -ne 's/^ID=//p' | tr -d '"')
fi

# Load target-specific initializer
INSTALLER=$(curl -fsSL --fail "https://get.cloudr.sh/target/${DIST}-${ARCH}/install.sh" 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "Network error or target not supported: ${DIST}-${ARCH}" >&2
  exit 1
fi

# And start that target's installer
bash -c "${INSTALLER}"
