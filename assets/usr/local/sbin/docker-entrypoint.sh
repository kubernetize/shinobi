#!/bin/sh

set -e

: ${SHINOBI_LISTEN_PORT:=8080}
: ${DB_USER:=majesticflame}
: ${DB_PASSWORD:=''}
: ${DB_HOST:=localhost}
: ${DB_DATABASE:=ccio}
: ${DB_PORT:=3306}
: ${DB_TYPE:=mysql}

# Create initial configuration based on environment variables
if ! test -f /config/conf.json ; then
	cat <<EOF > /config/conf.json
{
  "port": $SHINOBI_LISTEN_PORT,
  "debugLog": false,
  "passwordType": "sha512",
  "detectorMergePamRegionTriggers": true,
  "wallClockTimestampAsDefault": true,
  "useBetterP2P": true,
  "smtpServerOptions": {},
  "addStorage": [],
  "databaseType": "${DB_TYPE}",
  "db": {
    "host": "${DB_HOST}",
    "user": "${DB_USER}",
    "password": "${DB_PASSWORD}",
    "database": "${DB_DATABASE}",
    "port": ${DB_PORT}
  },
  "mail":{},
  "thisIsDocker": true,
  "ssl": {}
}
EOF
fi

exec "$@"
