FROM spark-base

RUN apt update && apt install -y vim && apt install -y net-tools && apt install -y iputils-ping

# -- Runtime
ARG spark_master_web_ui=8080

EXPOSE ${spark_master_web_ui} ${SPARK_MASTER_PORT}

#Create the workspace/events shared dir and start Spark Master
CMD bash -c "mkdir -p /opt/workspace/events && mkdir -p /opt/workspace/datain && mkdir -p /opt/workspace/dataout && bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out"

