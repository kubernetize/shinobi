#!/bin/sh

set -e

: ${SHINOBI_COMMIT_ID:=4aa2dad7}

if ! test -f package.json; then
	curl -sL https://gitlab.com/Shinobi-Systems/Shinobi/-/archive/${SHINOBI_COMMIT_ID}.tar.gz | tar xzf - --strip-components=1
fi

npm install
