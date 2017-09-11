FROM frolvlad/alpine-scala:2.12

RUN mkdir /etc/kafka-manager
WORKDIR /etc/kafka-manager

RUN apk -U --no-cache add --virtual .build-dependencies ca-certificates wget && update-ca-certificates && \
    cd /tmp && \
    wget https://cocl.us/sbt-1.0.1.tgz && \
    tar -zxvf sbt-1.0.1.tgz && \
    wget https://github.com/dnelson/kafka-manager/archive/master.tar.gz && \
    tar -zxvf master.tar.gz && \
    cd kafka-manager-master && \
    /tmp/sbt/bin/sbt clean dist && \
    unzip target/universal/kafka-manager-1.3.3.13.zip -d /etc/kafka-manager && \
    rm -rf /tmp/* && \
    mv /etc/kafka-manager/kafka-manager-1.3.3.13/* /etc/kafka-manager/. && \
    rm /etc/kafka-manager/kafka-manager-1.3.3.13

    # apk del .build-dependencies
