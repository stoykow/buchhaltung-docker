#!/bin/sh
set -eu

: "${SMTP_HOST:?SMTP_HOST fehlt}"
: "${SMTP_PORT:=587}"
: "${SMTP_FROM:?SMTP_FROM fehlt}"
: "${SMTP_USER:?SMTP_USER fehlt}"
: "${SMTP_PASSWORD:?SMTP_PASSWORD fehlt}"

TLS_STARTTLS="on"
if [ "$SMTP_PORT" = "465" ]; then
  TLS_STARTTLS="off"
fi

cat > /etc/msmtprc <<EOF
defaults
auth           on
tls            on
tls_starttls   ${TLS_STARTTLS}
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host ${SMTP_HOST}
port ${SMTP_PORT}
from ${SMTP_FROM}
user ${SMTP_USER}
password ${SMTP_PASSWORD}
EOF

chmod 600 /etc/msmtprc

exec "$@"
