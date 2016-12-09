# example run command

docker rm mysql-drupal drupal-test

docker run --name mysql-drupal -v C:\Development\Web\Data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:latest
docker run --name drupal-test --link mysql-drupal:mysql -p 8000:80 -d sinfidel/drupal