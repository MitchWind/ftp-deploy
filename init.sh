#!/bin/bash
echo "=== Environment variables ==="
echo "INPUT_SERVER: ${INPUT_SERVER}"
echo $INPUT_SERVER

echo $server

if type lftp >/dev/null 2>&1; then 
  echo 'exists lftp' 
else 
  echo 'no exists lftp'
  sudo apt-get install lftp 
fi
