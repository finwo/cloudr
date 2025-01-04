#!/bin/bash

# Exit on failures
set -e

# Ensure we're running as root
if [ "$EUID" -ne 0 ]; then
  echo "Root permissions are required for this installer to work" >&2
  exit 1
fi

mkdir -p /etc/sv/cloudr
cat <<EOF > /etc/sv/cloudr/run
#!/bin/sh
if /usr/sbin/cloudr; then
  sv down cloudr
fi
EOF
chmod +x /etc/sv/cloudr/run

# Install main binary
mkdir -p /usr/sbin
base64 -d <<EOF > /usr/sbin/cloudr
IyEvYmluL3NoCgp4YnBzLWluc3RhbGwgLVMKeGJwcy1pbnN0YWxsIC15IGpxCgojIEhhbmRsZSBq
c29uIG1ldGEKTUVUQT0kKGNhdCAvc3lzL2NsYXNzL2RtaS9pZC9jaGFzc2lzX2Fzc2V0X3RhZykK
aWYgWyAhIC16ICIke01FVEF9IiBdOyB0aGVuCiAgaWYgcHJpbnRmICIlcyIgIiR7TUVUQX0iIHwg
anEgLWUgLiAyPi9kZXYvbnVsbDsgdGhlbgogICAgIyBHaXZlbiBob3N0bmFtZSA9IHVzZSBpdAog
ICAgaWYgJChwcmludGYgIiVzIiAiJHtNRVRBfSIgfCBqcSAtciAnaGFzKCJob3N0bmFtZSIpJyk7
IHRoZW4KICAgICAgcHJpbnRmICIlcyIgIiR7TUVUQX0iIHwganEgLXIgLmhvc3RuYW1lID4gL2V0
Yy9ob3N0bmFtZQogICAgICBob3N0bmFtZSAkKGNhdCAvZXRjL2hvc3RuYW1lKQogICAgZmkKICBm
aQpmaQo=
EOF
chmod +x /usr/sbin/cloudr

ln -s /etc/sv/cloudr /var/service/cloudr
