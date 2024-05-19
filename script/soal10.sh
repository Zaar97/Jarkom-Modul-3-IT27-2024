mkdir /etc/nginx/supersecret
htpasswd -c /etc/nginx/supersecret/htpasswd secmart 

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo '
upstream worker {
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

server {
    listen 80;
    server_name harkonen.it27.com www.harkonen.it27.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;   
    }
    
    auth_basic "Restricted Content";
    auth_basic_user_file /etc/nginx/supersecret/htpasswd;
}' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
