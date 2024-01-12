FROM alpine:3.18

ARG VERSION=6.1.2.1

COPY .docker/config.settings /tmp/config.settings
COPY .docker/crontab /tmp/crontab
COPY .docker/entrypoint.sh /bin/entrypoint

WORKDIR /opt/src/unrealircd

RUN set -x \
  # create ircd user
  && addgroup -g 1000 -S ircd \
  && adduser -u 1000 -D -G ircd ircd \
  # install packages
  && apk --no-cache add libcurl openssl \
  && apk --no-cache add --virtual .build-deps gcc make binutils libc6-compat \
   g++ openssl-dev curl curl-dev busybox-suid \
  # get unrealircd source files
  && curl -OL "https://www.unrealircd.org/downloads/unrealircd-${VERSION}.tar.gz" \
  && tar xvfz "unrealircd-${VERSION}.tar.gz" \
  && cd /opt/src/unrealircd/unrealircd-${VERSION} \
  && cp /tmp/config.settings /opt/src/unrealircd/unrealircd-${VERSION}/config.settings \
  # build and install unrealircd
  && ./Config -quick \
  && make -j$(nproc) \
  && make install \
  # setup cron
  && cat /tmp/crontab | crontab -u ircd - \
  # clean up
  && apk --no-cache del .build-deps \
  && rm -rf /opt/src/* /tmp/crontab /tmp/config.settings \
  # finalize
  && chmod +x /bin/entrypoint \
  && mkdir -p /app/tls \
  && chown -R ircd:ircd . /usr/unrealircd /app

USER ircd
WORKDIR /usr/unrealircd

CMD ["/bin/entrypoint"]
