#!/bin/sh

# 1. Ortam değişkenlerini kontrol et
required_vars="MYSQL_DATABASE MYSQL_ROOT_PASSWORD MYSQL_USER MYSQL_PASSWORD"
for var in $required_vars; do
    [ -z "$(eval echo \$$var)" ] && { echo "$var gerekli" >&2; exit 1; }
done

# 2. İlk kurulum kontrolü
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then # eger veritabani yoksa kurulum yapar
    echo "⏳ MariaDB ilk kurulumu başlatılıyor..."
    
    # 3. Geçici MariaDB sunucusu (sadece socket üzerinden)
    mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock & #burada test amacli mariadb calistirilir PID atanir networksüz calisir
    MYSQL_PID=$!
    
    # 4. Başlangıç kontrolü (30 saniye timeout)
    echo "⌛ MariaDB başlatılıyor..."
    timeout=30
    while ! mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
        sleep 1
        timeout=$((timeout-1))
        [ $timeout -le 0 ] && { echo "❌ MariaDB başlatma zaman aşımı" >&2; exit 1; }
    done

    # 5. Temel veritabanı kurulumu
    echo "🔨 Veritabanı ve kullanıcı oluşturuluyor..." # database olusturulur flush tüm yetki degisiklerini uygular yeni kullaniciya verir
    mysql --socket=/var/run/mysqld/mysqld.sock <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE user='';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # 6. Geçici sunucuyu kapat
    kill $MYSQL_PID
    wait $MYSQL_PID
    echo "✅ MariaDB kurulumu tamamlandı"
fi

# 7. Normal çalışma modunda başlat (WordPress ve NGINX erişimi için)
echo "🚀 MariaDB servisi başlatılıyor..."
exec mysqld --bind-address=0.0.0.0 # setup.sh yerine mysqld gecirilir ve PID1 olur