FROM apache/zeppelin:0.9.0

# https://zeppelin.apache.org/docs/latest/interpreter/spark.html
ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2

ENV TZ=America/Sao_Paulo

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends net-tools curl iputils-ping ack

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN apt-get install -y telnet links neovim

# Decide: Install conda to manage python and R packages. Maybe adjust the packages in pip_packages.txt or conda_packages.txt
RUN rm -rf /opt/conda
ARG miniconda_version="py38_4.8.3"
ARG miniconda_sha256="879457af6a0bf5b34b48c12de31d4df0ee2f06a8e68768e5758c3293b2daf688"
# Install python and R packages via conda
COPY conda_packages.txt /conda_packages.txt
# Some python packages are not available via conda, so we are using pip
COPY pip_packages.txt /pip_packages.txt
RUN set -ex && \
    wget -nv https://repo.anaconda.com/miniconda/Miniconda3-${miniconda_version}-Linux-x86_64.sh -O miniconda.sh && \
    echo "${miniconda_sha256} miniconda.sh" > anaconda.sha256 && \
    sha256sum --strict -c anaconda.sha256 && \
    bash miniconda.sh -b -p /opt/conda && \
    export PATH=/opt/conda/bin:$PATH && \
    conda config --set always_yes yes --set changeps1 no && \
    conda info -a && \
    conda config --add channels conda-forge && \
    #conda install -y --quiet --file /conda_packages.txt && \
    conda install -y --file /conda_packages.txt && \
    pip install -q -r /pip_packages.txt  && \
    # Cleanup
    rm -v miniconda.sh anaconda.sha256  && \
    # Cleanup based on https://github.com/ContinuumIO/docker-images/commit/cac3352bf21a26fa0b97925b578fb24a0fe8c383
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    conda clean -ay
    # Allow to modify conda packages. This allows malicious code to be injected into other interpreter sessions, therefore it is disabled by default
    # chmod -R ug+rwX /opt/conda

