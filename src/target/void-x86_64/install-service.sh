mkdir -p /etc/sv/cloudr
cat <<EOF > /etc/sv/cloudr/run
#!/bin/sh
if /usr/sbin/cloudr; then
  sv down cloudr
fi
EOF
chmod +x /etc/sv/cloudr/run
