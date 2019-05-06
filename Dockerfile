FROM alpine:3.9

ARG HUGO_VERSION=0.55.5

ENV HUGO_BASE_URL http://localhost:1313

LABEL maintainer="ed@orphans.co.uk" \
    version="1.0"

# Prepare OS
RUN addgroup -g 1000 -S hugo \
    && adduser -u 1000 -G hugo -h /hugo -D hugo \
    && apk add curl rsync

# Install Hugo
RUN curl -o /tmp/hugo.tar.gz -SL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar xzf /tmp/hugo.tar.gz -C /tmp/ \
    && ls -l /tmp \
    && mv /tmp/hugo /usr/local/bin/hugo

# Cleanup 
RUN apk del curl \
    && rm -rf /var/cache/apk/* /tmp/*

# Environment settings
EXPOSE 1313
USER hugo
VOLUME  ["/hugo"]
WORKDIR /hugo

ONBUILD RUN hugo -d /hugo/public/

CMD hugo server -D -b ${HUGO_BASE_URL} --bind=0.0.0.0
