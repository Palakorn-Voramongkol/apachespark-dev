# Use a Debian-based image
FROM python:3.12-bullseye

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres
ENV POSTGRES_VERSION=16

# Install dependencies
RUN apt-get update && \
  apt-get install -y gnupg2 wget lsb-release && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  apt-get install -y postgresql-$POSTGRES_VERSION postgresql-client-$POSTGRES_VERSION && \
  rm -rf /var/lib/apt/lists/*

# Set up the PostgreSQL data directory
RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql

# Set up the entrypoint script
COPY postgres_entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the PostgreSQL port
EXPOSE 5432

# Switch to the postgres user and start PostgreSQL
USER postgres
ENTRYPOINT ["entrypoint.sh"]
