FROM romeoz/docker-apache-php:7.1
RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev pkg-config
RUN apt-get install -y php7.1-dev
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
  && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
  && apt-get update \
  && apt-get install -y mongodb-org --no-install-recommends \
  && apt-get install -y libssl-dev unzip \
  && pecl install mongodb \
  && php --ini \
  && echo "extension=mongodb.so" >> /etc/php/7.1/cli/php.ini \
  && echo "extension=mongodb.so" >> /etc/php/7.1/apache2/conf.d/custom.ini \
  #&& echo "extension=mongodb.so" >> /etc/php/7.1/apache2/php.ini \

  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "extension=mongodb.so" >> /etc/php/7.1/apache2/php.ini
ADD phpinfo.php /var/www/app/phpinfo.php
RUN php -v

RUN php -m