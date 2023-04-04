#!/bin/sh

set -e

: ${SHINOBI_LISTEN_PORT:=8080}
: ${DB_USER:=majesticflame}
: ${DB_PASSWORD:=''}
: ${DB_HOST:=localhost}
: ${DB_DATABASE:=ccio}
: ${DB_PORT:=3306}
: ${DB_TYPE:=mysql}

# Create configuration based on environment variables
if ! test -f /config/conf.json ; then
	cat <<EOF > /config/conf.json
{
  "port": $SHINOBI_LISTEN_PORT,
  "debugLog": false,
  "enableFaceManager": false,
  "videosDir": "__DIR__/videos",
  "passwordType": "sha256",
  "detectorMergePamRegionTriggers": true,
  "wallClockTimestampAsDefault": true,
  "useBetterP2P": true,
  "smtpServerOptions": {},
  "addStorage": [
      {"name":"second","path":"__DIR__/videos2"}
  ],
  "databaseType": "${DB_TYPE}",
  "db": {
    "host": "${DB_HOST}",
    "user": "${DB_USER}",
    "password": "${DB_PASSWORD}",
    "database": "${DB_DATABASE}",
    "port": ${DB_PORT}
  },
  "mail":{},
  "cron":{},
  "pluginKeys":{},
  "thisIsDocker": true,
  "cpuUsageMarker": "CPU",
  "ssl": {}
}
EOF
fi

exec "$@"
