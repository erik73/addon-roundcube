ARG BUILD_FROM=ghcr.io/erik73/base:5.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG ROUNDCUBE_VERSION="1.6.11"

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Setup base
RUN apk add --no-cache \
    mariadb-client=11.4.5-r2 \
    nginx=1.28.0-r3 \ 
    php82=8.4.8-r0 \
    php82-fpm=8.2.28-r1 \
    php82-imap=8.2.28-r1 \
    php82-session=8.2.28-r1 \
    php82-mysqli=8.2.28-r1 \
    php82-opcache=8.2.28-r1 \
    php82-mbstring=8.2.28-r1 \
    php82-pdo_mysql=8.2.28-r1 \
    php82-curl=8.2.28-r1 \
    php82-xml=8.2.28-r1 \
    php82-dom=8.2.28-r1 \
    php82-intl=8.2.28-r1 \
    php82-ctype=8.2.28-r1 \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/syslogd-overlay-noarch.tar.xz" \
        | tar -C / -Jxpf - \
    && mkdir /var/www/roundcube \
    && curl -L -s "https://github.com/roundcube/roundcubemail/releases/download/${ROUNDCUBE_VERSION}/roundcubemail-${ROUNDCUBE_VERSION}-complete.tar.gz" \
        | tar zxvf - -C /var/www/roundcube --strip-components=1 \
#        && cp /var/www/roundcube/config/config.inc.php.sample /var/www/roundcube/config/config.inc.php \
        && rm -f -r \
        /tmp/* \
    && mkdir -p /run/systemd/journal

# Copy data for add-on
COPY rootfs /

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Erik Hilton <erikhilton73@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Erik73 Hassio-Addons" \
    org.opencontainers.image.authors="Erik Hilton <erikhilton73@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/erik73/hassio-addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
