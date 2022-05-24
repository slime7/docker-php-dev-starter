FROM php:7.4-fpm

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
# remove not necessary files
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf

#RUN usermod -u 1000 www-data

CMD ["php-fpm"]
