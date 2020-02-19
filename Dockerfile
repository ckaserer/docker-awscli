FROM centos:7

ADD https://www.amazontrust.com/repository/AmazonRootCA1.cer /etc/pki/ca-trust/source/anchors/amazon.crt
RUN update-ca-trust

RUN yum install -y \
        python3-pip \
        python3 \
        groff \
        unzip \
        socat \
        openssl && \
    yum clean all

ENV AWS_CONFIG_FILE=/.aws/config

# AWS CLI
RUN pip3 install \
        awscli \
        --upgrade && \
    mkdir -p /.aws

# AWS Scheduler CLI
RUN mkdir -p /usr/local/lib/python3.6/site-packages/ && \
    curl -fsSL https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/scheduler-cli.zip > scheduler-cli.zip && \
    unzip scheduler-cli.zip -d scheduler-cli && \
    (cd scheduler-cli && python3 setup.py install) && \
    rm -rf scheduler-cli.zip scheduler-cli

# AWS wrapper
COPY scripts/ /usr/local/bin/

# Alow container to run with anyuid
RUN chgrp -R 0 /usr/local/bin /.aws && \
    chmod -R g=u /usr/local/bin /.aws

CMD [ "aws" ]