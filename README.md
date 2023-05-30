# MinIO Server Deploy Bootstrap




​	This project serves as an installation image package for distributed object storage MinIO. The specific operating steps are as follows:

【Step 1】Configure `MINIO_HOME`：

```shell
vim ~/.bashrc

# MINIO
export MINIO_HOME=...
export PATH=$PATH:$MINIO_HOME/bin:$MINIO_HOME/sbin

source ~/.bashrc
```

【Step 2】Configure MiniO Server environment variables. You can refer to [minio servert configuration](https://min.io/docs/minio/linux/reference/minio-server/minio-server.html#id6)

```shell
vim conf/minio-env.conf

MINIO_ROOT_USER=...
MINIO_ROOT_PASSWORD=...
...
```

【Step 3】Configure MiniO Server Volumns about a mapping to node and drive. 

```shell
vim conf/minio-volumns.conf

node01      /data/minio/data1
node01      /data/minio/data2
node01      /data/minio/data3
node01      /data/minio/data4
node02      /data/minio/data1
node02      /data/minio/data2
node02      /data/minio/data3
node02      /data/minio/data4
...
```

【Step 4】Configure MiniO Server about all over the nodes in `conf/workers`.

【Step 5】In specific situations, it may be necessary to adjust deployment runtime parameters in `sbin/minio-start.sh`, such as running logs, service ports, and RPC ports.

【Step 6】Distribute the configured installation package to all node nodes.

【Step 7】Setup MinIO Server on any node to deploy minio cluser.

```shell
sbin/miniox.sh start
```





