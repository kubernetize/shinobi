FROM node:18-alpine3.17

ENV APP_USER=shinobi \
    APP_HOME=/home/Shinobi \
    APP_UID=21353

WORKDIR /home/Shinobi
COPY shinobi .
COPY assets /

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

ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]

CMD ["node", "camera.js"]
