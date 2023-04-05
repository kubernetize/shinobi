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
 npm install pg
)
