FROM php:8.4-fpm

ENV XDEBUG_CLIENT_HOST="host.docker.internal"
ENV XDEBUG_CLIENT_PORT=9003
ENV XDEBUG_IDE_KEY="docker"

RUN sed -i "s@http://deb.debian.org@http://mirrors.ustc.edu.cn@g" /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libpq-dev \
    g++ \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    #install Imagemagick & PHP Imagick ext
    && apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    && pecl install imagick && docker-php-ext-enable imagick \
    #\
    && apt-get purge --auto-remove -y g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    \
    && pecl update-channels \
    # install php-redis
    && pecl install redis \
    && docker-php-ext-enable redis \
    \
    # install GD and iconv
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    \
    # install apcu
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    \
    && docker-php-ext-install opcache \
    # 配置 Opcache 推荐值
    && echo "\n \
    opcache.enable=1\n \
    opcache.memory_consumption=128\n \
    opcache.interned_strings_buffer=8\n \
    opcache.max_accelerated_files=10000\n \
    opcache.validate_timestamps=0\n \
    opcache.revalidate_freq=0\n \
    " >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    #install Xdebug ext
    && pecl install xdebug-3.4.5 \
    && docker-php-ext-enable xdebug \
    && echo "\n \
    xdebug.mode=develop,debug\n \
    xdebug.start_with_request=yes\n \
    xdebug.discover_client_host=false\n \
    xdebug.client_port=${XDEBUG_CLIENT_PORT}\n \
    xdebug.client_host=${XDEBUG_CLIENT_HOST}\n \
    xdebug.idekey=${XDEBUG_IDE_KEY}\n \
    xdebug.log=/tmp/xdebug/xdebug-log.log\n \
    xdebug.output_dir=/tmp/xdebug\n \
    " >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    \
    && rm -rf /tmp/pear \
    \
    && sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf

#RUN usermod -u 1000 www-data

CMD ["php-fpm"]
