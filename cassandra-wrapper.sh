#!/bin/bash
## This is a wrapper that when executed will create a default KEYSPACE within a new Cassandra instance
## This approach is similar to the one mentioned in the following upstream issue: https://github.com/docker-library/cassandra/issues/104

if [ -z ${CASSANDRA_KEYSPACE} ]
then
  export CASSANDRA_KEYSPACE="example"
fi

if [ -z ${SLEEP_TIMER} ]
then
  sleep ${SLEEP_TIMER}
fi

QUERY="CREATE KEYSPACE IF NOT EXISTS ${CASSANDRA_KEYSPACE} WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};"
until echo ${QUERY} | cqlsh; do
  echo "cassandra-wrapper.sh: Cassandra is unavailable to create keyspace - retrying in 2 seconds"
  sleep 2
done &

exec /usr/local/bin/docker-entrypoint2.sh $@