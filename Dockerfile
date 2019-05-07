FROM alpine:3.9

ARG HUGO_VERSION=0.55.5

ENV HUGO_BASE_URL http://localhost:1313

# Prepare OS
RUN addgroup -g 1000 -S hugo && adduser -u 1000 -G hugo -h /hugo -D hugo 
RUN apk add rsync

# Install Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo.tar.gz
RUN tar -xf /tmp/hugo.tar.gz -C /tmp/
RUN mv /tmp/hugo /usr/local/bin/hugo

RUN which hugo

# Cleanup 
RUN rm -rf /var/cache/apk/* /tmp/*

# Environment settings
USER hugo
WORKDIR /hugo
EXPOSE 1313
VOLUME  ["/hugo"]

ONBUILD RUN hugo -d /hugo/public/

CMD ["hugo", "server", "-D", "--baseURL=${HUGO_BASE_URL}", "--bind=0.0.0.0"]
