wget --no-check-certificate 'https://drive.google.com/file/d/1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30/view?usp=sharing' -O '/var/www/harkonen.it27.com'
unzip -o /var/www/harkonen.it27.com -d /var/www/
rm /var/www/harkonen.it27.com
mv /var/www/modul-3 /var/www/harkonen.it27.com

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/harkonen.it27.com
ln -s /etc/nginx/sites-available/harkonen.it27.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default


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
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;  # Sesuaikan versi PHP dan socket
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}' > /etc/nginx/sites-available/harkonen.it27.com

service nginx restart
