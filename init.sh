#!/bin/bash
FTP_SETTINGS="set ftp:ssl-allow ${INPUT_SSL_ALLOW};"
FTP_SETTINGS="${FTP_SETTINGS} set net:timeout ${INPUT_NET_TIMEOUT};"
FTP_SETTINGS="${FTP_SETTINGS} set net:max-retries ${INPUT_NET_MAX_RETRIES};"

MIRROR_COMMAND="mirror --continue --reverse --no-perms -v "

if [ -z "${INPUT_SETTINGS}" ]; then
  FTP_SETTINGS="${FTP_SETTINGS} ${INPUT_SETTINGS}"
fi

if [ -z "${INPUT_SERVER_DIR}" ]; then
  INPUT_SERVER_DIR="./"
else
  if [ "${INPUT_SERVER_DIR}" != "./" ]; then
    INPUT_SERVER_DIR="${INPUT_SERVER_DIR}/"
  fi
fi

if [ -z "${INPUT_LOCAL_DIR}" ]; then
  INPUT_LOCAL_DIR="./"
else
  if [ "${INPUT_LOCAL_DIR}" != "./" ]; then
    INPUT_LOCAL_DIR="${INPUT_LOCAL_DIR}/"
  fi
fi

if [ "${INPUT_DELETE}" = "true" ]; then
  MIRROR_COMMAND="${MIRROR_COMMAND} --delete"
fi

if type lftp >/dev/null 2>&1; then 
  echo 'exists lftp'
else 
  sudo apt-get install lftp 
fi

lftp \
  -u "${INPUT_USERNAME}","${INPUT_PASSWORD}" \
  -p ${INPUT_PORT} \
  "${INPUT_SERVER}" \
  -e "${FTP_SETTINGS} ${MIRROR_COMMAND} ${INPUT_LOCAL_DIR} ${INPUT_SERVER_DIR}; quit;"