
FROM ubuntu:16.04
MAINTAINER Chris Moon <chris.moon@databricks.com>

RUN apt-get update
RUN apt-get -y install apt-transport-https \
                    ca-certificates \ 
                    curl \
                    software-properties-common
RUN echo "deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN apt update
RUN apt-get -y install libcurl4-openssl-dev \
                       libssl-dev \
                       libxml2-dev \
                       r-base \
                       r-base-core \
                       r-recommended \ 
                       r-base-dev

# Install Anaconda
ARG CONDA_DIR=/root/anaconda3
RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
RUN bash Anaconda3-2019.03-Linux-x86_64.sh -b
ENV PATH=$CONDA_DIR/bin:$PATH

RUN R -e "install.packages(c('mlflow', 'carrier'), repos='https://cloud.r-project.org')"

RUN R -e "library(mlflow);install_mlflow()"

RUN apt-get -y install python-pip
RUN pip install mlflow

COPY MLmodel /opt/ml/model/MLmodel
COPY crate.bin /opt/ml/model/crate.bin

#MLflow Serve port
EXPOSE 5001

WORKDIR /opt/ml

# Extra libraries for the model
RUN R -e "install.packages('glmnet')"
#RUN R -e "install.packages('caret')"

ENTRYPOINT ["/root/anaconda3/bin/mlflow", "models", "serve", "-m", "/opt/ml/model", "-h", "0.0.0.0", "-p", "5001"]
