FROM ibmjava:9-sdk

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      build-essential automake autoconf libtool \
      libafflib-dev zlib1g-dev libewf-dev \
    && cd /tmp/ && apt-get download ant && dpkg-deb -x ant*.deb / \
    && rm ant*.deb
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

COPY ./ /usr/local/src/sleuthkit/
WORKDIR /usr/local/src/sleuthkit/
RUN ./bootstrap
RUN ./configure --prefix=/usr/
RUN make
RUN make install
RUN make dist-gzip
