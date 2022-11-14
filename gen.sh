#!/bin/bash

if [[ -z "${ELECTRON_VERSION}" ]]; then
  echo electron version not defined;
  exit 1;
fi

FILENAME="node-v${ELECTRON_VERSION}.tar.gz"
ALT_FILENAME="node-v${ELECTRON_VERSION}-headers.tar.gz"
DISTURL_ROOT="https://www.electronjs.org/headers/v${ELECTRON_VERSION}"
PATCH_FILEPATH="../patches/v${ELECTRON_VERSION}.patch"

DIST_FILES=(
  "node-v${ELECTRON_VERSION}.tar.gz"
  # "node-v${ELECTRON_VERSION}-headers.tar.gz"
  "node.lib"
  "x64/node.lib"
  "win-x86/node.lib"
  "win-x64/node.lib"
  "arm64/node.lib"
  "win-arm64/node.lib"
)

mkdir -p v${ELECTRON_VERSION}
cd v${ELECTRON_VERSION}

# download dist files
for DIST_FILE in ${DIST_FILES[*]}; do
  mkdir -p $(dirname ${DIST_FILE})
  wget -O ${DIST_FILE} ${DISTURL_ROOT}/${DIST_FILE}
done

# extract header tarball
tar xvf ${FILENAME} > /dev/null
rm -f ${FILENAME}

# modify the files as needed
if [[ -f "${PATCH_FILEPATH}" ]]; then
  patch -p 1 -i ${PATCH_FILEPATH}
fi

# re-archive
tar czf ${FILENAME} node_headers > /dev/null
cp ${FILENAME} ${ALT_FILENAME}
rm -rf node_headers

# generate sha256 sums
sha256sum node-v${ELECTRON_VERSION}-headers.tar.gz ${DIST_FILES[*]} > SHASUMS256.txt

cd ..