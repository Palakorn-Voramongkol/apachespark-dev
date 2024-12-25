# Use Debian Buster base image with OpenJDK
ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}

# Set the shared workspace directory
ARG shared_workspace=/opt/workspace

# Create the shared workspace directory and install necessary packages
RUN mkdir -p ${shared_workspace} && \
    apt update -y && \
    apt install -y curl gcc && \
    apt install -y build-essential zlib1g-dev libncurses5-dev && \
    apt install -y libsqlite3-dev && \
    apt install -y libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
    curl -O https://www.python.org/ftp/python/3.9.19/Python-3.9.19.tar.xz && \
    tar -xf Python-3.9.19.tar.xz && cd Python-3.9.19 && ./configure && make -j 8 && \
    make install && \
    apt update && apt install -y procps && apt install -y vim && apt install -y net-tools && \
    rm -rf /var/lib/apt/lists/*

# Set the shared workspace environment variable
ENV SHARED_WORKSPACE=${shared_workspace}

# Expose the shared workspace as a volume
VOLUME ${shared_workspace}

# Set the default command to bash
CMD ["bash"]
