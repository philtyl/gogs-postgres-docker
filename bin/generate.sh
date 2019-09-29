#!/usr/bin/env bash

HERE=$(dirname "$0")
SECRET_KEYS=(postgres-root postgres-userpass gogs-secret-key gogs-admin-userpass)
declare -A SECRETS

echo "Creating runtime configurations..."
for f in "${HERE}"/../config/{.,}*; do
  if [ -f "${f}" ]; then
    echo "  Runtime configurations detected: ${f}"
    cp "${f}" "${HERE}"/../config/run/
  fi
done

echo "Generating Secrets..."
for key in "${SECRET_KEYS[@]}"; do
  SECRETS[${key}]=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c"${1:-32}";echo;)
  echo "${SECRETS[${key}]}" | docker secret create "${key}" -
  echo "  ${key}: ${SECRETS[${key}]}"

  for f in "${HERE}"/../config/run/{.,}*; do
    if [ -f "${f}" ]; then
      sed -i "s/\${${key}}/${SECRETS[${key}]}/g" "${f}"
    fi
  done
done

echo "Completing config localization..."
for f in "${HERE}"/../config/run/{.,}*; do
  if [ -f "${f}" ]; then
    sed -i -E "s/^(.*?)\\$\((.+?)\)(.*)/eval \2 | echo \"&\"/e" "${f}"
  fi
done