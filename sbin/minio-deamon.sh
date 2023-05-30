#!/bin/bash

if [ "x$MINIO_HOME" = "x" ]; then
  echo "Please specify to env MINIO_HOME"
  exit
fi

case $1 in

"start")
  $MINIO_HOME/sbin/minio-start.sh
  ;;

"stop")
  $MINIO_HOME/sbin/minio-stop.sh
  ;;

"restart")
  $MINIO_HOME/sbin/minio-stop.sh
  sleep 5
  $MINIO_HOME/sbin/minio-start.sh
  ;;

"status")
  $MINIO_HOME/sbin/minio-status.sh
  ;;

*)
  echo Invalid Args!
  echo 'Usage: '$(basename $0)' start|stop|restart|status'
  ;;

esac
