FROM php:8.3-fpm-alpine

WORKDIR /var/www/${APP_NAME}
 
# Install system dependencies and PHP extensions
RUN apk update && apk add --no-cache \
    bash \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zlib-dev \
    libxml2-dev \
    oniguruma-dev \
    npm \
    git \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip pdo pdo_mysql gd

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI globally
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Set working directory
WORKDIR /var/www/${APP_NAME}

# Expose PHP-FPM port
EXPOSE 9000