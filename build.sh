#!/bin/sh

set -e

: ${SHINOBI_COMMIT_ID:=4aa2dad7}

if ! test -f shinobi/package.json; then
	mkdir -p shinobi
	curl -sL https://gitlab.com/Shinobi-Systems/Shinobi/-/archive/${SHINOBI_COMMIT_ID}.tar.gz | tar xzf - --strip-components=1 -C shinobi
fi

(
 cd shinobi
 npm install
 npm install pkg

 node_modules/.bin/pkg package.json -t node18-linuxstatic-x64,node18-linuxstatic-arm64,node18-linuxstatic-arm --out-path dist
 # conform to Docker TARGETARCH
 mv dist/shinobi-x64 dist/shinobi-amd64
 mv dist/shinobi-armv7 dist/shinobi-arm
)

rm -rf dist
mv shinobi/dist .
