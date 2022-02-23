FROM php:7.4-apache

ENV TZ 'America/Sao_Paulo'
RUN echo TZ > /etc/timezone && RUN apt-get update -y

RUN docker-php-ext-install mysqli pdo pdo_mysql mbstring
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd

RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

COPY projects/ /var/www/html
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

EXPOSE 80
