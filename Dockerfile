# Use the specific Postgres image based on Alpine 3.21
FROM postgres:17.4-alpine3.21

# Set environment variables for PostgreSQL
# These are typical settings; adjust as needed for your project
# Use ARG for parameterization
# ENV POSTGRES_USER=tsAdmin
# ENV POSTGRES_PASSWORD=
# ENV POSTGRES_DB=postgres

# Copy initialization scripts into the Docker image
# Place your SQL load script in the same directory as this Dockerfile
COPY ddl/*.sql /docker-entrypoint-initdb.d/

# Declare a volume mount point
VOLUME /var/lib/postgresql/data

# Copy other configuration files if needed
# For example, a custom PostgreSQL configuration file
# COPY custom-postgresql.conf /etc/postgresql/postgresql.conf

# Optional: Ensure the script is executable (not necessary for .sql files)
# RUN chmod +x /docker-entrypoint-initdb.d/load-script.sql

# Expose PostgreSQL's default port
EXPOSE 5432

# The default command is already defined in the base image, which starts PostgreSQL
# No need to override unless special behavior is required