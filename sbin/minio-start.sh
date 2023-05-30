#!/bin/bash

# ######################################################
# MinIO Server Startup Configuration
# ######################################################
MINIO_SERVER_PORT=9000
MINIO_CONSOLE_ADDRESS_PORT=50000
MINIO_SERVER_LOG_DIR=
# ######################################################

# export MINIO_HOME=
if [ "x$MINIO_HOME" = "x" ]; then
  echo "Please specify to env MINIO_HOME"
  exit
fi

# minio address port to use
# MINIO_SERVER_PORT=
if [ "x$MINIO_SERVER_PORT" = "x" ]; then
  MINIO_SERVER_PORT=9000
fi

# minio console address port to use
# MINIO_CONSOLE_ADDRESS_PORT=
if [ "x$MINIO_CONSOLE_ADDRESS_PORT" = "x" ]; then
  MINIO_CONSOLE_ADDRESS_PORT=50000
fi

# minio server log dir to use
# MINIO_SERVER_LOG_DIR=
if [ "x$MINIO_SERVER_LOG_DIR" = "x" ]; then
  MINIO_SERVER_LOG_DIR=$MINIO_HOME/logs
fi

if [ ! -d $MINIO_SERVER_LOG_DIR ]; then
  mkdir -p $MINIO_SERVER_LOG_DIR
fi

volumns_server=`cat $MINIO_HOME/conf/minio-volumns.conf | grep '^[^#]' | awk '{print $1}' | sort -u | wc -l`

# minio volumns
MINIO_VOLUMES=
if [ $volumns_server -eq 1 ]; then
  for volumn in `cat $MINIO_HOME/conf/minio-volumns.conf | grep '^[^#]' | awk '{print $2}'`
  do
    MINIO_VOLUMES="$MINIO_VOLUMES $volumn"
  done
else
  for volumn in `cat $MINIO_HOME/conf/minio-volumns.conf | grep '^[^#]' | awk '{print "http://"$1$2}'`
  do
    MINIO_VOLUMES="$MINIO_VOLUMES $volumn"
  done
fi
echo "minio server volumns: $MINIO_VOLUMES"


# load minio config env file
export MINIO_CONFIG_ENV_FILE=$MINIO_HOME/conf/minio-env.conf

now=`date +%Y-%m-%d@%H-%M-%S.%N`
user=`whoami`

# start minio server
nohup $MINIO_HOME/bin/minio server \
$MINIO_VOLUMES \
--address ":$MINIO_SERVER_PORT" \
--console-address ":$MINIO_CONSOLE_ADDRESS_PORT" > $MINIO_SERVER_LOG_DIR/minio-server-$user-$now.log 2>&1 &
