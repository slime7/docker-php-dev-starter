FROM php:7.4-fpm

ENV XDEBUG_CLIENT_HOST="host.docker.internal"
ENV XDEBUG_CLIENT_PORT=9003
ENV XDEBUG_IDE_KEY="docker"

RUN sed -i "s@http://deb.debian.org@http://mirrors.ustc.edu.cn@g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libpq-dev \
    g++ \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    libmcrypt-dev \
    libonig-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && apt-get purge --auto-remove -y g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    \
    && pecl update-channels \
    # install php-redis and mcrypt
    && pecl install redis mcrypt-1.0.4 \
    && docker-php-ext-enable redis mcrypt \
    \
    # install GD and iconv
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    \
    # install apcu
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    \
    #install Imagemagick & PHP Imagick ext
    && apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick && docker-php-ext-enable imagick \
    \
    #install Xdebug ext
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "\n \
    xdebug.mode=debug\n \
    xdebug.start_with_request=yes\n \
    xdebug.discover_client_host=false\n \
    xdebug.client_port=${XDEBUG_CLIENT_PORT}\n \
    xdebug.client_host=${XDEBUG_CLIENT_HOST}\n \
    xdebug.idekey=${XDEBUG_IDE_KEY}\n \
    xdebug.log=/tmp/xdebug/xdebug-log.log\n \
    xdebug.output_dir=/tmp/xdebug\n \
    " >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    \
    # remove not necessary files
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf

#RUN usermod -u 1000 www-data

CMD ["php-fpm"]
