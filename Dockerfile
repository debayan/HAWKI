FROM php:7.4-apache

RUN a2enmod rewrite

# Install the PHP cURL extension
RUN apt-get update && apt-get install -y libcurl4-openssl-dev pkg-config \
    && docker-php-ext-install curl

# Configure Apache to log to stdout and stderr
RUN ln -sfT /dev/stderr /var/log/apache2/error.log && \
    ln -sfT /dev/stdout /var/log/apache2/access.log


RUN chown -R www-data:www-data /var/www/html

COPY . /var/www/html
EXPOSE 80

CMD ["apache2-foreground"]
