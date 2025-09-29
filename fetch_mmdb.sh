#!/usr/bin/env bash
set -euo pipefail

# Download and install the DB-IP City Lite database
# Target: data/GeoLite2-City.mmdb (kept same filename our app expects)

URL_DEFAULT="https://download.db-ip.com/free/dbip-city-lite-2025-09.mmdb.gz"
URL="${1:-$URL_DEFAULT}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR=""${SCRIPT_DIR}"/data"
TARGET_MMDB=""${DATA_DIR}"/GeoLite2-City.mmdb"
TMP_GZ=""${DATA_DIR}"/dbip-city-lite.mmdb.gz"

mkdir -p "${DATA_DIR}"

echo "Downloading MMDB gzip from: ${URL}" >&2
curl -fL "${URL}" -o "${TMP_GZ}"

echo "Unpacking gzip..." >&2
gunzip -f "${TMP_GZ}"

# gunzip will remove .gz and leave .mmdb with same base name
SRC_MMDB="${DATA_DIR}/dbip-city-lite.mmdb"
if [[ ! -f "${SRC_MMDB}" ]]; then
  echo "Expected ${SRC_MMDB} not found after decompression" >&2
  exit 1
fi

mv -f "${SRC_MMDB}" "${TARGET_MMDB}"

echo "Database installed at: ${TARGET_MMDB}" >&2