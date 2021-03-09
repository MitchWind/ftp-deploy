#!/bin/bash
FTP_SETTINGS="set ftp:ssl-allow ${INPUT_SSL_ALLOW};"
FTP_SETTINGS="${FTP_SETTINGS} set net:timeout ${INPUT_NET_TIMEOUT};"
FTP_SETTINGS="${FTP_SETTINGS} set net:max-retries ${INPUT_NET_MAX_RETRIES};"
FTP_SETTINGS="${FTP_SETTINGS} set net:reconnect-interval-multiplier ${INPUT_NET_RECONNECT_INTERVAL_MULTIPLIER};"
FTP_SETTINGS="${FTP_SETTINGS} set net:reconnect-interval-base ${INPUT_NET_RECONNECT_INTERVAL_BASE};"
FTP_SETTINGS="${FTP_SETTINGS} set net:persist-retries ${INPUT_NET_PERSIST_RETRIES};"
FTP_SETTINGS="${FTP_SETTINGS} set ftp:nop-interval ${INPUT_NOP_INTERVAL};"
#保留原始时间
# FTP_SETTINGS="${FTP_SETTINGS} set ftp:use-mdtm-overloaded true;" 
# FTP_SETTINGS="${FTP_SETTINGS} set ftp:use-mlsd ${INPUT_USE_MLSD};"
FTP_SETTINGS="${FTP_SETTINGS} set ftp:use-mdtm ${INPUT_USE_MDTM};"
FTP_SETTINGS="${FTP_SETTINGS} set ftp:passive-mode ${INPUT_PASSIVE_MODE};"
MIRROR_COMMAND="mirror --continue --reverse --verbose=3 -x ^\.git/$ "
#自定义参数设置
if [ -z "${INPUT_SETTINGS}" ]; then
  FTP_SETTINGS="${FTP_SETTINGS} ${INPUT_SETTINGS}"
fi
#服务器路径
if [ -z "${INPUT_SERVER_DIR}" ]; then
  INPUT_SERVER_DIR="./"
else
  if [ "${INPUT_SERVER_DIR}" != "./" ]; then
    INPUT_SERVER_DIR="${INPUT_SERVER_DIR}/"
  fi
fi
#本地文件路径
if [ -z "${INPUT_LOCAL_DIR}" ]; then
  INPUT_LOCAL_DIR="./"
else
  if [ "${INPUT_LOCAL_DIR}" != "./" ]; then
    INPUT_LOCAL_DIR="${INPUT_LOCAL_DIR}/"
  fi
fi
#自定义mirror参数
if [ -z "${INPUT_OPTIONS}" ]; then
  MIRROR_COMMAND="${MIRROR_COMMAND} ${INPUT_OPTIONS}"
fi
#不设置文件权限
if [ "${INPUT_NO_PERMS}" = "true" ]; then
  MIRROR_COMMAND="${MIRROR_COMMAND} --no-perms"
fi
#删除不存在文件
if [ "${INPUT_DELETE}" = "true" ]; then
  MIRROR_COMMAND="${MIRROR_COMMAND} --delete"
fi

#是否开启调试模式
if [ "${INPUT_DEBUG}" = "true" ]; then
  FTP_SYNTAX="--debug"
fi

if type lftp >/dev/null 2>&1; then 
  echo 'exists lftp'
else 
  sudo -E apt-get -qq install lftp 
fi

lftp \
  "${FTP_SYNTAX}" \
  -u "${INPUT_USERNAME}","${INPUT_PASSWORD}" \
  -p ${INPUT_PORT} \
  "${INPUT_SERVER}" \
  -e "${FTP_SETTINGS} ${MIRROR_COMMAND} ${INPUT_LOCAL_DIR} ${INPUT_SERVER_DIR}; quit;"