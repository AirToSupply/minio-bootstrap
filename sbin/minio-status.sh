#!/bin/bash

pid=$(ps -ef 2>/dev/null | grep -i "bin/minio server" | grep -v grep | awk '{print $2}')

if [ "x$pid" = "x" ]; then
  echo "MinIO Server [Inactive]"
else
  echo "MinIO Server [Active]"
fi
