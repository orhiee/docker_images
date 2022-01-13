# based on: https://github.com/zeek/zeek/blob/master/docker/Dockerfile
# See the file "COPYING" in the main distribution directory for copyright.

# Layer to build Zeek.
FROM debian:bullseye-slim AS build

# Configure system for build.
RUN apt-get -q update \
 && apt-get install -q -y --no-install-recommends \
     bind9 \
     bison \
     cmake \
     flex \
     g++ \
     gcc \
     libmaxminddb-dev \
     libpcap-dev \
     libssl-dev \
     libz-dev \
     make \
     python3-minimal \
     python3.9-dev \
     swig \
     ninja-build \
     python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy over the Zeek source tree.
# NOTE: This assumes that we build in the context of the parent directory (the
# Git checkout root). We e.g., ensure that in the `Makefile` in this directory.
#COPY . /src/zeek
#updated for new git location in zeek folder
COPY ./zeek/ /src/zeek
RUN make -C /src/zeek distclean

ARG CONFFLAGS="--generator=Ninja --build-type=Release"

WORKDIR /src/zeek
RUN ./configure $CONFFLAGS && ninja -C build install


# Final layer containing all artifacts.
FROM debian:bullseye-slim AS final

RUN apt-get -q update \
 && apt-get install -q -y --no-install-recommends \
     ca-certificates \
     git \
     libmaxminddb0 \
     libpython3.9 \
     libpcap0.8 \
     libssl1.1 \
     libz1 \
     python3-minimal \
     python3-git \
     python3-semantic-version \
     net-tools \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
## added net-tools

# Copy over Zeek installation.
COPY --from=build /usr/local/zeek /usr/local/zeek
ENV PATH "/usr/local/zeek/bin:${PATH}"
ENV PYTHONPATH "/usr/local/zeek/lib/zeek/python:${PYTHONPATH}"

# customizations:
## update output log format to JSON
RUN sed -i 's/use_json = F/use_json = T/g' /usr/local/zeek/share/zeek/base/frameworks/logging/writers/ascii.zeek

## enable treat intell: download and enable 
RUN git clone https://github.com/CriticalPathSecurity/Zeek-Intelligence-Feeds.git /usr/local/zeek/share/zeek/site/Zeek-Intelligence-Feeds && echo "@load Zeek-Intelligence-Feeds" >> /usr/local/zeek/share/zeek/site/local.zeek

## add run.sh
RUN mkdir -p /opt/zeek
COPY run.sh /opt/zeek/
RUN chmod +x /opt/zeek/run.sh

ENTRYPOINT ["/opt/zeek/run.sh"]
