# #!/bin/sh

# # WordPress'i indir ve kur
# curl -O https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# cp -r wordpress/* /var/www/html/
# rm -rf wordpress latest.tar.gz

# # wp-config.php dosyasını oluştur
# cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sed -i "s/database_name_here/${MYSQL_DATABASE}/" /var/www/html/wp-config.php
# sed -i "s/username_here/${MYSQL_USER}/" /var/www/html/wp-config.php
# sed -i "s/password_here/$(cat ${MYSQL_PASSWORD_FILE})/" /var/www/html/wp-config.php
# sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php

# # PHP-FPM'i ön planda çalıştır
# exec php-fpm
#!/bin/sh
set -e

# WordPress'i indir ve kur
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress latest.tar.gz

# wp-config.php dosyasını oluştur
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/${MYSQL_DATABASE}/" /var/www/html/wp-config.php
sed -i "s/username_here/${MYSQL_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/$(cat ${MYSQL_PASSWORD_FILE})/" /var/www/html/wp-config.php
sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php

# Güvenlik anahtarlarını WordPress CLI ile üretip wp-config.php'ye ekle
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=$(cat ${MYSQL_PASSWORD_FILE}) --dbhost=mariadb --skip-salts --path=/var/www/html
wp config set AUTH_KEY "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep AUTH_KEY | cut -d"'" -f2)" --raw
wp config set SECURE_AUTH_KEY "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep SECURE_AUTH_KEY | cut -d"'" -f2)" --raw
wp config set LOGGED_IN_KEY "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep LOGGED_IN_KEY | cut -d"'" -f2)" --raw
wp config set NONCE_KEY "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep NONCE_KEY | cut -d"'" -f2)" --raw
wp config set AUTH_SALT "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep AUTH_SALT | cut -d"'" -f2)" --raw
wp config set SECURE_AUTH_SALT "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep SECURE_AUTH_SALT | cut -d"'" -f2)" --raw
wp config set LOGGED_IN_SALT "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep LOGGED_IN_SALT | cut -d"'" -f2)" --raw
wp config set NONCE_SALT "$(curl -s https://api.wordpress.org/secret-key/1.1/salt/ | grep NONCE_SALT | cut -d"'" -f2)" --raw

# PHP-FPM'i ön planda çalıştır
exec php-fpm