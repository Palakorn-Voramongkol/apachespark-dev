# Use the official pgAdmin image from Docker Hub
FROM dpage/pgadmin4:latest

# Set environment variables
ENV PGADMIN_DEFAULT_EMAIL=admin@example.com
ENV PGADMIN_DEFAULT_PASSWORD=admin
ENV PGADMIN_LISTEN_PORT=80

# Expose the pgAdmin port
EXPOSE 80

# Start the pgAdmin server
CMD ["python", "/pgadmin4/pgAdmin4.py"]
