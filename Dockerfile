FROM centos:8

ENV PATH=~/.local/bin:${PATH}
ADD https://www.amazontrust.com/repository/AmazonRootCA1.cer /etc/pki/ca-trust/source/anchors/amazon.crt
RUN update-ca-trust

RUN dnf install -y --enablerepo=PowerTools python3-pip groff && \
    dnf clean all && \
    pip3 install awscli --upgrade --user

CMD [ "aws" ]