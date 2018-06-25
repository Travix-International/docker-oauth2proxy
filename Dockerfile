FROM travix/base-alpine:3.5

MAINTAINER Travix

ENV OAUTH2_PROXY_VERSION=2.2.0 \
    GOLANG_VERSION=1.8.1

RUN apk --update add curl apache2-utils ca-certificates \
  && mkdir -p /tmp/oauth2_proxy \
  && cd /tmp/oauth2_proxy \
  && curl -fSL -o oauth2_proxy.tar.gz \
    "https://github.com/bitly/oauth2_proxy/releases/download/v${OAUTH2_PROXY_VERSION%.*}/oauth2_proxy-${OAUTH2_PROXY_VERSION}.linux-amd64.go${GOLANG_VERSION}.tar.gz" \
  && tar xzvf oauth2_proxy.tar.gz \
  && mv oauth2_proxy-${OAUTH2_PROXY_VERSION}.linux-amd64.go${GOLANG_VERSION}/oauth2_proxy /usr/bin/ \
  && chmod +x /usr/bin/oauth2_proxy \
  && rm -rf /tmp/oauth2_proxy \
  && rm -rf /tmp/oauth2_proxy /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
