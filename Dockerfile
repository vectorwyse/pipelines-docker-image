FROM node:14-alpine3.14 AS node
FROM php:7.3-cli-alpine3.14

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

ENV COMPOSER_HOME /root/composer
ENV COMPOSER_VERSION 2.0.14
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps-composer \
        autoconf \
        automake \
        g++ \
        make \
        libtool \
        nasm \
        file \
        rsync \
        zlib-dev \
        libzip-dev \
        icu-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        git \
        unzip \
        openssh-client \
        bash \
        xvfb \
        grep \
        findutils \
        curl \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        exif \
        zip \
        intl \
        gd \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version $COMPOSER_VERSION

RUN Xvfb -ac :0 -screen 0 1280x1024x16 &
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
