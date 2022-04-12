FROM prooph/php:8.0-cli

ENV COMPOSER_HOME /root/composer
ENV COMPOSER_VERSION 2.0.14
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps-composer \
        zlib-dev \
        libzip-dev \
        git \
        unzip \
        openssh-client \
        nodejs \
        npm \
        chromium \
    && docker-php-ext-install \
        exif \
        zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version $COMPOSER_VERSION

CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
