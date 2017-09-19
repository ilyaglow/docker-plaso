FROM alpine:edge
LABEL maintainer "ilya@ilyaglotov.com"

ARG TZ=Europe/London

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV CFLAGS="$CFLAGS -D_GNU_SOURCE"

# Install dependencies
RUN apk update \
  && apk add python \
             python-dev \
             py-pip \
             xz-dev \
             zeromq \
             \
  # Install dependencies
  && apk add --virtual .temp \
                       build-base \
                       git \
                       linux-headers \
                       tzdata \
                       \
  && rm -rf /var/cache/apk/* \
  \
  # Add new user
  && adduser -D plaso \
  \
  # Set up timezone
  && cp /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  \
  # Install plaso
  && git clone --branch=master \
               --depth=1 \
               https://github.com/log2timeline/plaso.git \
               /plaso \
  && cd /plaso \
  && pip install -r requirements.txt \
  && pip install elasticsearch \
  && python setup.py install \
  \
  # Clean up
  && apk del .temp \
  && rm -rf /root/.cache \
  && rm -rf /plaso

VOLUME /data

WORKDIR /data

USER plaso

ENTRYPOINT ["log2timeline.py"]
