FROM node:22-alpine3.21 AS node
FROM php:8.3-cli-alpine3.21

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

ENV COMPOSER_HOME /root/composer
ENV COMPOSER_VERSION 2.0.14
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

RUN set -xe \
    && apk add --no-cache php83-pecl-imagick --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        g++ \
        make \
        libtool \
    && apk add --no-cache --virtual .persistent-deps-composer \
        zlib-dev \
        libzip-dev \
        git \
        unzip \
        openssh-client \
        bash \
        xvfb \
        chromium \
        chromium-chromedriver \
        imagemagick \
        imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build-deps \
    && docker-php-ext-install \
        exif \
        zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version $COMPOSER_VERSION

RUN Xvfb -ac :0 -screen 0 1280x1024x16 &
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
