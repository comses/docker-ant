FROM comses/base:noble

LABEL maintainer="allen.lee@asu.edu"

ENV DEBIAN_FRONTEND=noninteractive \
	LANG=C.UTF-8 \
	LC_ALL=C.UTF-8 \
	ANT_VERSION=1.10.15 \
    ANT_MIRROR=https://downloads.apache.org \
	ANT_HOME=/opt/ant

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends openjdk-21-jdk wget \
    && wget --no-check-certificate --no-cookies ${ANT_MIRROR}/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
# FIXME: add PGP checking: https://ant.apache.org/bindownload.cgi?Preferred=http%3A%2F%2Fapache.cs.utah.edu%2F
    # && wget --no-check-certificate --no-cookies ${ANT_MIRROR}/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz.md5 \
    # && echo "$(cat apache-ant-${ANT_VERSION}-bin.tar.gz.md5) apache-ant-${ANT_VERSION}-bin.tar.gz" | md5sum -c - \
    && tar -zvxf apache-ant-${ANT_VERSION}-bin.tar.gz -C /opt/ \
    && ln -sf /opt/apache-ant-${ANT_VERSION} /opt/ant \
    && rm -f apache-ant-${ANT_VERSION}-bin.tar.gz* \
    && update-alternatives --install /usr/bin/ant ant /opt/ant/bin/ant 1000 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code
USER $COMSES_USER
