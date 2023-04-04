FROM alpine:3.17

ARG TARGETARCH

ENV APP_USER=shinobi \
    APP_HOME=/home/Shinobi \
    APP_UID=21353

WORKDIR /home/Shinobi
COPY shinobi .
COPY dist/shinobi-${TARGETARCH} shinobi
COPY kubernetize.entrypoint.sh .

RUN adduser -u $APP_UID -D -h $APP_HOME $APP_USER && \
    mkdir -p /config && \
    chown $APP_UID /config && \
    ln -s /config/conf.json /home/Shinobi && \
    ln -s /config/super.json /home/Shinobi && \
    apk --no-cache add ffmpeg

VOLUME ["/home/Shinobi/videos"]
VOLUME ["/home/Shinobi/libs/customAutoLoad"]
VOLUME ["/config"]

EXPOSE 8080

USER $APP_UID

ENTRYPOINT ["/home/Shinobi/kubernetize.entrypoint.sh"]

CMD ["./shinobi"]
