#!/bin/ash
rm -rf /home/container/tmp/*

echo -e "\033[32m⟳\033[0m Iniciando PHP-FPM..."
/usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo -e "\033[32m⟳\033[0m Iniciando Nginx..."
echo -e "\033[32m⟳\033[0m Validando versión de php..."
php -v
echo -e "\033[32m✓\033[0m Servidor web iniciado con éxito"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/
