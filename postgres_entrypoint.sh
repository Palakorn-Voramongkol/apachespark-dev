#!/bin/bash
set -e

# Ensure the PATH includes PostgreSQL binaries
export PATH="/usr/lib/postgresql/${POSTGRES_VERSION}/bin:${PATH}"

# Initialize the database if it doesn't exist
if [ ! -s /var/lib/postgresql/data/PG_VERSION ]; then
    pg_ctl initdb -D /var/lib/postgresql/data
    pg_ctl start -D /var/lib/postgresql/data -w

    # Set the password for the postgres user
    psql --username postgres -c "ALTER USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';"

    createdb --username postgres --owner=$POSTGRES_USER $POSTGRES_DB
    pg_ctl stop -D /var/lib/postgresql/data -m fast

    # Update pg_hba.conf to allow all IPs
    echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
    echo "host all all ::/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

    # Update postgresql.conf to listen on all addresses
    sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/data/postgresql.conf
fi

# Ensure listen_addresses is set correctly
if ! grep -q "^listen_addresses = '*'" /var/lib/postgresql/data/postgresql.conf; then
    echo "listen_addresses = '*'" >> /var/lib/postgresql/data/postgresql.conf
fi

# Ensure pg_hba.conf allows all IPs
if ! grep -q "host all all 0.0.0.0/0 md5" /var/lib/postgresql/data/pg_hba.conf; then
    echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
fi
if ! grep -q "host all all ::/0 md5" /var/lib/postgresql/data/pg_hba.conf; then
    echo "host all all ::/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
fi

# Start PostgreSQL
exec postgres -D /var/lib/postgresql/data
