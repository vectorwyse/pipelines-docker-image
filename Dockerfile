FROM prooph/php:8.2-cli

ENV COMPOSER_HOME /root/composer
ENV COMPOSER_VERSION 2.0.14
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

RUN set -xe \
    && apk add --no-cache php82-pecl-imagick --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && apk add --no-cache --virtual .persistent-deps-composer \
        zlib-dev \
        libzip-dev \
        git \
        unzip \
        openssh-client \
        bash \
        nodejs \
        npm \
        xvfb \
        chromium \
        chromium-chromedriver \
        imagemagick \
        imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
        exif \
        zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version $COMPOSER_VERSION

RUN npm install -g n
RUN n 22

RUN Xvfb -ac :0 -screen 0 1280x1024x16 &
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
