FROM apache/zeppelin:0.9.0

# https://zeppelin.apache.org/docs/latest/interpreter/spark.html
ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2

ENV TZ=America/Sao_Paulo

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get install -y --no-install-recommends net-tools curl iputils-ping ack

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN apt-get install -y telnet links

