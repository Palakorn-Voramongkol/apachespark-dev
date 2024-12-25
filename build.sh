SPARK_VERSION="3.4.3"
HADOOP_VERSION="3"
JUPYTERLAB_VERSION="4.2.4"
PGADMIN_VERSION="7.2"

# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t cluster-base .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile \
  -t spark-base .

docker build \
  -f spark-master.Dockerfile \
  -t spark-master .

docker build \
  -f spark-worker.Dockerfile \
  -t spark-worker .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .

docker build \
  -f postgres.Dockerfile \
  -t postgres16 .

docker build \
  --build-arg pgadmin_version="${PGADMIN_VERSION}" \
  -f pgadmin.Dockerfile \
  -t pgadmin4 .

#docker build \
#  -f cassandra.Dockerfile \
#  -t cassandra .