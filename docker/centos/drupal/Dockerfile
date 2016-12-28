FROM centos:latest

LABEL \
    BASE_OS="CentOS 7" \
    DEFAULT_TAG="8.2" \
    DESCRIPTION="CentOS 7 / httpd 2.4.23 / php 7.1.0 / drupal " \
    VERSION="1.0" \
    UID="DRUPAL_8.2"

RUN yum -y update \
 && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
 && yum -y install \
    httpd24u \
    httpd24u-mod_ssl \
    mod_php71u \
    php71u-cli \
    php71u-common \
#   php71u-fpm \
#   php71u-fpm-httpd \
    php71u-gd \
    php71u-json \
    php71u-mbstring \
    php71u-mysqlnd \
    php71u-opcache \
    php71u-pdo \
    php71u-pecl-xdebug \
    php71u-pgsql \
    php71u-xml \
 && yum clean all

RUN { \
    echo "ServerName localhost"                            ; \
    echo "ServerSignature Off"                             ; \
    echo "ServerTokens Prod"                               ; \
    echo "TraceEnable Off"                                 ; \
    echo "Header always append X-Frame-Options SAMEORIGIN" ; \
    echo "Header set X-XSS-Protection \"1; mode=block\""   ; \
    echo                                                   ; \
    echo "AccessFileName .htaccess"                        ; \
    echo "DirectoryIndex disabled"                         ; \
    echo "DirectoryIndex index.php index.html"             ; \
    echo                                                   ; \
    echo "<FilesMatch \.php$>"                             ; \
    echo "    SetHandler application/x-httpd-php"          ; \
    echo "</FilesMatch>"                                   ; \
    echo                                                   ; \
    echo "<Directory /var/www/html/>"                      ; \
    echo "    Options -Indexes"                            ; \
    echo "    AllowOverride All"                           ; \
    echo "</Directory>"                                    ; \
} | tee "/etc/httpd/conf.d/docker-php.conf"

RUN { \
    echo "[opcache]"                          ; \
    echo "opcache.memory_consumption=128"     ; \
    echo "opcache.interned_strings_buffer=8"  ; \
    echo "opcache.max_accelerated_files=4000" ; \
    echo "opcache.revalidate_freq=60"         ; \
    echo "opcache.fast_shutdown=1"            ; \
    echo "opcache.enable_cli=1"               ; \
} | tee "/etc/php.d/opcache.ini"

RUN { \
    echo "[xdebug]"                           ; \
    echo "xdebug.remote_enable = 1"           ; \
    echo "xdebug.remote_autostart = 1"        ; \
} | tee "/etc/php.d/xdebug.ini"

# https://www.drupal.org/node/3060/release
RUN curl https://getcomposer.org/download/1.2.1/composer.phar -o /usr/local/bin/composer \
 && chmod 755 /usr/local/bin/drush /usr/local/bin/composer \
 && chown -R apache:apache /var/www/html

RUN  composer create-project \
    drupal-composer/drupal-project:8.x-dev \
    /var/www/html \
    --stability dev \
    --no-interaction

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-k", "start", "-DFOREGROUND"]



