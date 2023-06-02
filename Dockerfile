FROM alpine:latest

RUN apk --update --no-cache add curl ca-certificates nginx
RUN apk add php8 php8-xml php8-exif php8-fpm php8-session php8-soap php8-openssl php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip php8-mysqli php8-sqlite3 php8-pdo_pgsql php8-bcmath php8-gd php8-odbc php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv php8-pdo_dblib php8-curl php8-ctype php8-phar php8-fileinfo php8-mbstring php8-tokenizer php8-simplexml
COPY --from=composer:latest  /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache wget unzip && \
    wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar -zxvf ioncube_loaders_lin_x86-64.tar.gz && \
    cp ioncube/ioncube_loader_lin_8.0.so $(php -r "echo ini_get('extension_dir');")/ioncube.so && \
    echo "zend_extension=ioncube.so" > $(php -r "echo php_ini_loaded_file();")-ioncube.ini && \
    rm -rf ./ioncube ioncube_loaders_lin_x86-64.tar.gz && \
    apk del wget unzip

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
