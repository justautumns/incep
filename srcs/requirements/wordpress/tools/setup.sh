#!/bin/sh
set -e

echo "🌐 WordPress kurulumu başlatılıyor..."

# WP-CLI kurulumu
if ! command -v wp >/dev/null 2>&1; then
    echo "⚙️ WP-CLI kuruluyor..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# WordPress dosyaları indiriliyor (yalnızca daha önce indirilmemişse)
if [ ! -f /var/www/html/wp-load.php ]; then
    echo "📥 WordPress indiriliyor..."
    wp core download --path=/var/www/html --allow-root
    chown -R www-data:www-data /var/www/html
fi

cd /var/www/html

# wp-config.php oluşturuluyor
if [ ! -f wp-config.php ]; then
    echo "🛠 wp-config.php oluşturuluyor..."
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
fi

# WordPress kurulumu yapılıyor
if ! wp core is-installed --allow-root; then
    echo "🔧 WordPress ilk yapılandırma yapılıyor..."
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
fi

echo "✅ WordPress kurulumu tamamlandı. PHP-FPM başlatılıyor..."
exec php-fpm8.2 -F
