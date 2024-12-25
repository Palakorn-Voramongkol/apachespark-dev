FROM cluster-base

# -- Layer: JupyterLab

ARG spark_version=3.4.3
ARG jupyterlab_version=4.2.3

RUN apt update -y && \
    apt install -y python3-pip && \
    pip install pypandoc==1.5 && \
    pip install pyspark==${spark_version} jupyterlab==${jupyterlab_version} && \
    pip install wget && \
    pip install numpy && pip install pandas && pip install matplotlib && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/local/bin/python3 /usr/bin/python

# Create Jupyter configuration directory
RUN mkdir -p /root/.jupyter/

# Copy the Jupyter configuration file into the container
COPY jupyter_notebook_config.py /root/.jupyter/

# Increase memory limits for the container
ENV MEM_LIMIT 6G  # Adjust based on your requirements

# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]
