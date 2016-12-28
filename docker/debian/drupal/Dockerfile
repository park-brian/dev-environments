FROM debian:latest

LABEL \
    BASE_OS="Debian 8" \
    DEFAULT_IMAGE="sinfidel/drupal" \
    DEFAULT_TAG="8.2.4" \
    DESCRIPTION="Debian 8 / Apache 2.4.10 / php 7.0 / drupal 8.2.4" \
    VERSION="8.2.4" \
    UID="DRUPAL_8.2.4"


## unstable
RUN { \
    echo "deb http://deb.debian.org/debian unstable main"        ; \
    echo "deb http://deb.debian.org/debian jessie-updates main"  ; \
    echo "deb http://security.debian.org jessie/updates main"    ; \
} | tee "/etc/apt/sources.list"


## Install apache and php
RUN apt update -y \
 && apt install -y apache2 php


## drupal-specific apache config
## RUN { \
##     echo "ServerName localhost"                            ; \
##     echo "ServerSignature Off"                             ; \
##     echo "ServerTokens Prod"                               ; \
##     echo "TraceEnable Off"                                 ; \
##     echo "Header always append X-Frame-Options SAMEORIGIN" ; \
##     echo "Header set X-XSS-Protection \"1; mode=block\""   ; \
##     echo                                                   ; \
##     echo "AccessFileName .htaccess"                        ; \
##     echo "DirectoryIndex disabled"                         ; \
##     echo "DirectoryIndex index.php index.html"             ; \
##     echo                                                   ; \
##     echo "<FilesMatch \.php$>"                             ; \
##     echo "    SetHandler application/x-httpd-php"          ; \
##     echo "</FilesMatch>"                                   ; \
##     echo                                                   ; \
##     echo "<Directory /var/www/html/>"                      ; \
##     echo "    Options -Indexes"                            ; \
##     echo "    AllowOverride All"                           ; \
##     echo "</Directory>"                                    ; \
## } | tee "/etc/apache2/conf.d/docker-php.conf"
## 
## 
## ## opcache
## RUN { \
##     echo "opcache.memory_consumption=128"     ; \
##     echo "opcache.interned_strings_buffer=8"  ; \
##     echo "opcache.max_accelerated_files=4000" ; \
##     echo "opcache.revalidate_freq=60"         ; \
##     echo "opcache.fast_shutdown=1"            ; \
##     echo "opcache.enable_cli=1"               ; \
## } | tee "/etc/php.d/opcache-recommended.ini"
## 






WORKDIR /var/www/html

RUN apt install -y curl

# https://www.drupal.org/node/3060/release
RUN curl https://ftp.drupal.org/files/projects/drupal-8.2.4.tar.gz | tar -xz --strip-components=1 \
 && curl https://s3.amazonaws.com/files.drush.org/drush.phar -o /usr/local/bin/drush \
 && curl https://getcomposer.org/download/1.2.1/composer.phar -o /usr/local/bin/composer \
 && chown -R www-data:www-data /var/www/html \
 && chmod 755 /usr/local/bin/drush /usr/local/bin/composer


EXPOSE 80 443


#ENTRYPOINT ["/usr/sbin/apache2"]
#CMD ["-k", "start", "-DFOREGROUND"]



