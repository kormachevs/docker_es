FROM alpine

RUN apk update && apk add jq && apk add bash && apk add curl && rm -rf /var/cache/apk/*
COPY ./json-file/*.json /tmp/
COPY ./script/script.bash /

ENTRYPOINT ./script.bash
