## This Dockerfile is a basic wrapper for the Docker library Cassandra image. It supports all of the default 
## environment variables however it allows users to specify a CASSANDRA_KEYSPACE environment variable. When this variable 
## is set the specified keyspace will be created automatically after boot up. If no CASSANDRA_KEYSPACE environment 
## variable is defined an "example" keyspace will be created.
FROM cassandra:latest
RUN mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint2.sh
ADD ./cassandra-wrapper.sh /usr/local/bin/docker-entrypoint.sh