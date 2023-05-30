#!/bin/bash

for node in `cat $MINIO_HOME/conf/workers`
do
  echo "********************************" [ $node ] "************************************"
  ssh $node $MINIO_HOME/sbin/minio-deamon.sh $1
  echo "*******************************************************************************"
done
