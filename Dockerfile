FROM alpine:3.13

COPY teeproxy.go /usr/local/src/

RUN apk add --no-cache go musl-dev \
    && cd /usr/local/src/ \
    && CGO_ENABLED=0 go build teeproxy.go \
    && mv teeproxy /usr/local/bin/ \
    && apk add --no-cache --update ca-certificates \
    && go version \
    && apk del go musl-dev

ENTRYPOINT ["/usr/local/bin/teeproxy"]
