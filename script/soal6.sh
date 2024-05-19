apt-get update
apt-get install nginx wget unzip php7.3 php-fpm -y

service nginx start

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30' -O 'harkonen.zip'
unzip harkonen.zip

# meletakkan komponen web
mkdir -p /var/www/harkonen.it27.com
mv modul-3 /var/www/harkonen.it27.com/

rm -rf modul-3
rm harkonen.zip

echo 'server {
    listen 80;

    server_name _;

    root /var/www/harkonen.it27.com;
    index index.php index.html index.htm;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
    }

    error_log /var/log/nginx/harkonen.it27.com_error.log;
    access_log /var/log/nginx/harkonen.it27.com_access.log;
}
' > /etc/nginx/sites-available/harkonen.it27.com.conf

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/harkonen.it27.com.conf /etc/nginx/sites-enabled/

service nginx restart
service php7.3-fpm start
