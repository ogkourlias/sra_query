################## BASE IMAGE ######################

FROM ubuntu:23.04

################## METADATA ######################
LABEL base_image="ubuntu:23.04"
LABEL version="1.0.0"
LABEL software="SRA Query Pipeline"

################## MAINTAINER ######################

LABEL maintainer="Orfeas Gkourlias <o.gkourlias@umcg.nl>"


################## INSTALLATION ######################
ADD . /app
ADD . /tmp/init
WORKDIR /app

ENV SHELL=/bin/bash
ENV LC_ALL=C
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV LANG=C.UTF-8
ENV TZ=Europe
ENV DEBIAN_FRONTEND=noninteractive

# Getting base apps & languages.
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
        # Getters & VSC.
        wget=1.21.3-1ubuntu1 \
        git=1:2.39.2-1ubuntu1.1

# Non-apt Tools
RUN cd /tmp/init
RUN wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
RUN tar -vxzf sratoolkit.tar.gz
RUN mv sratoolkit.3.0.10-ubuntu64 /opt
ENV PATH="${PATH}:/opt/sratoolkit.3.0.10-ubuntu64/bin"

################## CLEANUP ######################
# Apt cleanup.
RUN apt-get clean \
    && apt-get autoremove -y

# Build files cleanup
RUN cd /app
RUN rm -rf /tmp/init