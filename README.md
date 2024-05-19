# Jarkom-Modul-3-IT27-2024

| Nama | NRP |
| ---------------------- | ---------- |
| Azzahra Sekar Rahmadina | 5027221035 |
| Zulfa Hafizh Kusuma | 5027221038 |

## List of Contents
- [Official Report](#official-report)
  - [List of Contents](#list-of-contents)
  - [Topology](#topology)
  - [Network Configurations](#network-configurations)
  - [Prerequisite](#prerequisite)
- [Soal 1](#soal-1)
- [Soal 2,3,4,5](#soal-2,3,4,5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)

## Topology

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/59e95f50-8db4-40c5-b0a7-0f96bcb929f3)

## Network Configuration
- **Router (DHCP Relay)**
  - Arakis
    ```bash
    auto eth0
    iface eth0 inet dhcp
    up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.77.0.0/16

    auto eth1
    iface eth1 inet static
    address 10.77.1.0
    netmask 255.255.255.0

    auto eth2
    iface eth2 inet static
    address 10.77.2.0
    netmask 255.255.255.0

    auto eth3
    iface eth3 inet static
    address 10.77.3.0
    netmask 255.255.255.0

    auto eth4
    iface eth4 inet static
    address 10.77.4.0
    netmask 255.255.255.0
    ```

- **DHCP Server**
  - Mohiam
    ```bash
    auto eth0
    iface eth0 inet static
    address 10.77.3.1
    netmask 255.255.255.0
    gateway 10.77.3.0
    ```

- **DNS Server**
  - Irulan
    ```bash
    auto eth0
    iface eth0 inet static
    address 10.77.3.2
    netmask 255.255.255.0
    gateway 10.77.3.0  
    ```

- **Database Server**
  - Chani
    ```bash
    auto eth0
	iface eth0 inet static
	address 10.77.4.1
	netmask 255.255.255.0
	gateway 10.77.4.0  
    ```

- **Load Balancer**
  - Stilgar
    ```bash
    auto eth0
	iface eth0 inet static
	address 10.77.4.2
	netmask 255.255.255.0
	gateway 10.77.4.0  
    ```

- **Laravel Worker**
  - Leto
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.2.1
  	netmask 255.255.255.0
  	gateway 10.77.2.0  
    ```

  - Duncan
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.2.2
  	netmask 255.255.255.0
  	gateway 10.77.2.0       
    ```
      
  - Jessica
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.2.3
  	netmask 255.255.255.0
  	gateway 10.77.2.0        
    ```

- **PHP Worker**
  - Vladimir
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.1.1
  	netmask 255.255.255.0
  	gateway 10.77.1.0  
    ```      

  - Rabban
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.1.2
  	netmask 255.255.255.0
  	gateway 10.77.1.0        
    ```

  - Feyd
    ```bash
    auto eth0
	iface eth0 inet static
  	address 10.77.1.3
  	netmask 255.255.255.0
  	gateway 10.77.1.0        
    ```

- **Client**
  - Dmitri
    ```bash
    auto eth0
	iface eth0 inet dhcp       
    ```

  - Paul
    ```bash
    auto eth0
	iface eth0 inet dhcp        
    ```

## Prerequisite

Setiap node, kita inisiasi pada root `.bashrc` menggunakan `nano`

- **DNS Server**
  ```bash
	
	apt-get update
	apt-get install bind9 -y

  	echo '
	options {
    	directory "/var/cache/bind";

    	forwarders {
        	192.168.122.1;
    	};

    	// dnssec-validation auto;
    	allow-query { any; };
    	auth-nxdomain no;    # conform to RFC1035
    	listen-on-v6 { any; };
    	};' > /etc/bind/named.conf.options       
  ```
- **DHCP Server**
  ```bash
	echo 'nameserver 10.77.3.2' > /etc/resolv.conf  
	apt-get update
	apt install isc-dhcp-server -y       
  ```
- **DHCP Relay**
  ```bash
	apt-get update
	apt install isc-dhcp-relay -y
  	service isc-dhcp-relay start     
  ```
- **Database Server**
  ```bash
	echo 'nameserver 10.77.3.2' > /etc/resolv.conf
	apt-get update
	apt-get install mariadb-server -y
	service mysql start

	Lalu jangan lupa untuk mengganti [bind-address] pada file /etc/mysql/mariadb.conf.d/50-server.cnf menjadi 0.0.0.0 dan jangan lupa untuk melakukan restart mysql kembali 
  ```
- **Load Balancer**
  ```bash
	echo 'nameserver 10.77.3.2' > /etc/resolv.conf
	apt-get update
	apt-get install apache2-utils -y
	apt-get install nginx -y
	apt-get install lynx -y

	service nginx start     
  ```
- **Worker PHP**
  ```bash
	echo 'nameserver 10.77.3.2' > /etc/resolv.conf
	apt-get update
	apt-get install nginx -y
	apt-get install wget -y
	apt-get install unzip -y
	apt-get install lynx -y
	apt-get install htop -y
	apt-get install apache2-utils -y
	apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y

	service nginx start
	service php7.3-fpm start    
  ```
- **Worker Laravel**
  ```bash
	echo 'nameserver 10.77.3.2' > /etc/resolv.conf
	apt-get update
	apt-get install lynx -y
	apt-get install mariadb-client -y
	# Test connection from worker to database
	# mariadb --host=10.77.4.1 --port=3306   --user=kelompokit27 --password=passwordit27 dbkelompokit27 -e "SHOW DATABASES;"
	apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
	curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
	sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
	apt-get update
	apt-get install php8.0-mbstring php8.0-xml php8.0-cli   php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
	apt-get install nginx -y

	service nginx start
	service php8.0-fpm start    
  ```
- **Client**
  ```bash
	apt-get update
	apt-get install lynx -y
	apt-get install htop -y
	apt-get install apache2-utils -y
	apt-get install jq -y     
  ```

## Soal 1

> Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.
Pertama kita perlu mempersiapkan konfigurasi topologi dan setup seperti aturan diatas. Selanjutnya untuk kebutuhan testing, kita perlu menambahkan register domain name atreides.yyy.com untuk worker Laravel mengarah pada Leto Atreides dan mendaftarkan domain name harkonen.yyy.com untuk worker PHP mengarah pada Vladimir Harkonen

- **Leto (Laravel Worker)**
  ```bash
  auto eth0
  iface eth0 inet static
  address 10.77.2.1
  netmask 255.255.255.0
  gateway 10.77.2.0  
  ```

- **Vladimir (PHP Worker)**
  ```bash
  auto eth0
  iface eth0 inet static
  address 10.77.1.1
  netmask 255.255.255.0
  gateway 10.77.1.0  
  ```

### Script

Selanjutnya pada DNS Server (Irulan), kita perlu menjalankan command dibawah ini

```bash
echo 'zone "atreides.it27.com" {
        type master;
        file "/etc/bind/jarkom/atreides.it27.com";
};


zone "harkonen.it27.com" {
        type master;
        file "/etc/bind/jarkom/harkonen.it27.com";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/atreides.it27.com
cp /etc/bind/db.local /etc/bind/jarkom/harkonen.it27.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it27.com. root.atreides.it27.com. (
                        2024051601      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      atreides.it27.com.
@               IN      A       10.77.2.1 ; IP Leto Laravel Workerr' > /etc/bind/jarkom/atreides.it27.com


echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it27.com.  harkonen.it27.com.  (
                        2024051601      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      harkonen.it27.com.
@               IN      A       10.77.1.1 ; IP Vladimir PHP Worker' > /etc/bind/jarkom/harkonen.it27.com


echo 'options {
        directory "/var/cache/bind";


        forwarders {
                192.168.122.1;
        };


        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 restart
```

## Soal 2,3,4,5

> - Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
> - Client yang melalui House Harkonen mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 
> - Client yang melalui House Atreides mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2 .200 - [prefix IP].2.210 
> - Client mendapatkan DNS dari Princess Irulan dan dapat terhubung dengan internet melalui DNS tersebut 
> - Durasi DHCP server meminjamkan alamat IP kepada Client yang melalui House Harkonen selama 5 menit sedangkan pada client yang melalui House Atreides selama 20 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit

### Script

lakukan konfigurasi DHCP Server pada Mohiam

```bash
apt-get update
apt-get install isc-dhcp-server -y

interfaces="INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"
"
echo "$interfaces" > /etc/default/isc-dhcp-server

subnet="option domain-name \"example.org\";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style-none;

subnet 10.77.1.0 netmask 255.255.255.0 {
    range 10.77.1.14 10.77.1.28;
    range 10.77.1.49 10.77.1.70;
    option routers 10.77.1.0;
    option broadcast-address 10.77.1.255;
    option domain-name-servers 10.77.3.2;
    default-lease-time 300;
    max-lease-time 5220;
}

subnet 10.77.2.0 netmask 255.255.255.0 {
    range 10.77.2.15 10.77.2.25;
    range 10.77.2.200 10.77.2.210;
    option routers 10.77.2.0;
    option broadcast-address 10.77.2.255;
    option domain-name-servers 10.77.3.2;
    default-lease-time 1200;
    max-lease-time 5220;
}

subnet 10.77.3.0 netmask 255.255.255.0 {
}

subnet 10.77.4.0 netmask 255.255.255.0 {
}

"
echo "$subnet" > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
```

### Testing Result

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/cfc74171-8d2c-48e6-b615-57572249d2ee)

`ip a`
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/e8713d49-09f1-4312-8138-f88a2b9bbf25)

`ping -c 5 google.com`

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/8386ad56-df8f-4584-b07e-e8de84caa263)

`ping -c 5 atreides.it27.com`

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/e6f94795-d6c5-43e2-b47a-8d7c5340af01)

`ping -c 5 harkonen.it27.com`

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/679302b1-aad5-40dd-a724-0f634a03ef37)

## Soal 6

> Vladimir Harkonen memerintahkan setiap worker(harkonen) PHP, untuk melakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3.

Sebelum mengerjakan perlu untuk melakukan [setup](#prerequisite) terlebih dahulu pada seluruh PHP Worker. Jika sudah, silahkan untuk melakukan konfigurasi tambahan sebagai berikut untuk melakukan download dan unzip menggunakan command wget

```bash
wget --no-check-certificate 'https://drive.google.com/file/d/1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30/view?usp=sharing' -O '/var/www/harkonen.it27.com'
unzip -o /var/www/harkonen.it27.com -d /var/www/
rm /var/www/harkonen.it27.com
mv /var/www/modul-3 /var/www/harkonen.it27.com
```

### Script

```bash
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
}' > /etc/nginx/sites-available/granz.channel.it26.com


service nginx restart
```

### Testing Result

Jalanin Perintah `lynx localhost` pada masing-masing worker dan hasilnya akan sebagai berikut:

## Soal 7
> Aturlah agar Stilgar dari fremen dapat dapat bekerja sama dengan maksimal, lalu lakukan testing dengan 5000 request dan 150 request/second.

Sebelum mengerjakan perlu untuk melakukan [setup](#prerequisite) terlebih dahulu. Setelah melakukan konfigurasi diatas, sekarang lakukan konfigurasi `Load Balancing` pada node `Stilgar` sebagai berikut

### Script
Sebelum melakukan setup soal 7. Buka kembali Node `DNS Server` dan arahkan domain tersebut pada IP `Load Balancer` `Stilgar`

```bash
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it27.com. root.atreides.it27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it27.com.
@       IN      A       10.77.4.2 ; IP Load Balancer Stilgar
@       IN      AAAA    ::1' > /etc/bind/atreides/atreides.it27.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it27.com. root.harkonen.it27.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      harkonen.it27.com.
@       IN      A       10.77.4.2 ; IP Load Balancer Stilgar
@       IN      AAAA    ::1' > /etc/bind/harkonen/harkonen.it27.com
```

Lalu kembali ke node `Stilgar` dan lakukan konfigurasi pada nginx sebagai berikut

```bash
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo ' upstream worker {
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
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart
```

### Testing Result

Jalankan perintah berikut pada client

```bash
ab -n 5000 -c 150 http://www.harkonen.it30.com/
```

## Soal 8
> Karena diminta untuk menuliskan peta tercepat menuju spice, buatlah analisis hasil testing dengan 500 request dan 50 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
> - Nama Algoritma Load Balancer
> - Report hasil testing pada Apache Benchmark
> - Grafik request per second untuk masing masing algoritma. 
> - Analisis

Edit file `/etc/nginx/sites-available/lb_php` dan tambahkan algoritma load balancer

```bash
echo ' upstream worker {
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream roundrobin_worker {
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream leastconn_worker {
    least_conn;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream weightedrr_worker {
    server 10.77.1.1 weight=3;
    server 10.77.1.2 weight=2;
    server 10.77.1.3 weight=1;
}

upstream iphash_worker {
    ip_hash;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream hash_worker {
    hash $request_uri consistent;
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
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
    }
    location /roundrobin {
        proxy_pass http://roundrobin_worker;
    }
    location /leastconn {
        proxy_pass http://leastconn_worker;
    }
    location /weightedrr {
        proxy_pass http://weightedrr_worker;
    }
    location /iphash {
        proxy_pass http://iphash_worker;
    }
    location /hash {
        proxy_pass http://hash_worker;
    }
} ' > /etc/nginx/sites-available/lb_php

service nginx restart
```

### Testing

**Round Robin**

**Least Connection**

**IP Hash**

**Generic Hash**

## Soal 9

> Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta

Setelah melakukan setup pada node Stilgar sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan 1 worker, 2 worker, dan 3 worker.

Jalankan command berikut pada client

```bash
ab -n 1000 -c 10 http://www.harkonen.it27.com/leastconn/
```

### Result

**3 Worker**

**2 Worker**

Sebelum testing, pastikan mengcomment IP worker yang ingin dimatikan pada file /etc/nginx/sites-available/lb_php
```bash
upstream leastconn_worker {
    least_conn;
    # server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}
```

**1 Worker**

Sebelum testing, pastikan mengcomment IP worker yang ingin dimatikan pada file /etc/nginx/sites-available/lb_php
```bash
upstream leastconn_worker {
    least_conn;
    # server 10.77.1.1;
    # server 10.77.1.2;
    server 10.77.1.3;
}
```
## Soal 10
> Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di LB dengan dengan kombinasi username: “secmart” dan password: “kcksyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/

## Soal 13
> Semua data yang diperlukan, diatur pada Chani dan harus dapat diakses oleh Leto, Duncan, dan Jessica

1. Masukkan IP DNS Server (Irulan) ke dalam Database Server (Chani) 
```
echo 'nameserver 10.77.3.2' > etc/resolv.conf
```

2. Masuk ke dalam MYSQL
```
mysql -u root -p
```
NOTE: password untuk user root adalah root

3. Eksekusi Query yang akan digunakan untuk aplikasi Laravel nanti
```
CREATE USER 'kelompokit27'@'%' IDENTIFIED BY 'passwordit27';
CREATE USER 'kelompokit27'@'localhost' IDENTIFIED BY 'passwordit27';
CREATE DATABASE dbkelompokit27;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit27'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit27'@'localhost';
FLUSH PRIVILEGES;
```

4. Lakukan konfigurasi pada `/etc/mysql/my.cnf` agar database dapat diakses oleh worker Laravel
```
[mysqld]
skip-networking=0
skip-bind-address
```

5. Ubah bind-address pada `/etc/mysql/mariadb.conf.d/50-server.cnf` menjadi seperti berikut
```
bind-address            = 0.0.0.0
```

6. Jangan lupa restart MYSQL 

7. Coba akses database dari Laravel Worker
```
mariadb --host=10.7.4.1 --port=3306 --user=kelompokit27 --password=passwordit27 dbkelompokit27
```
### Result
**Leto**<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/e3ccf558-6eb8-4af7-8be8-da088d35c08c)

**Duncan** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/e01e583c-b3cf-4411-ac7a-7c970f1b58b0)

**Jessica** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/ab6027f8-83b7-4435-ae30-3c47b64c0128)

## Soal 14
> Leto, Duncan, dan Jessica memiliki atreides Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer

- Script.sh 
  ```
  git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
  mv laravel-praktikum-jarkom /var/www/laravel-praktikum-jarkom

  cd /var/www/laravel-praktikum-jarkom
  composer update
  composer install
  # Mengganti nama file .env.example menjadi .env
  mv .env.example .env

  # Menambahkan konfigurasi ke dalam file .env
    echo "DB_CONNECTION=mysql" >> .env
    echo "DB_HOST=10.77.4.1" >> .env
    echo "DB_PORT=3306" >> .env
    echo "DB_DATABASE=dbkelompokit27" >> .env
    echo "DB_USERNAME=kelompokit27" >> .env
    echo "DB_PASSWORD=passwordit27" >> .env

  # Menjalankan migrasi database
    php artisan migrate:fresh

  # Menjalankan seed untuk tabel Airings
    php artisan db:seed --class=AiringsTableSeeder

  # Menghasilkan kunci aplikasi
    php artisan key:generate

  # Menghasilkan kunci JWT
    php artisan jwt:secret

  # Membuat symlink untuk penyimpanan
    php artisan storage:link

  # Menambahkan konfigurasi server Nginx ke dalam file laravel-worker
  echo 'server {
      listen 8001; #sesuaikan dengan worker tempat kita sekarang (leto 1, duncan 2, jessica 3)
      root /var/www/laravel-praktikum-jarkom/public;
      index index.php index.html index.htm;
      server_name _;
      location / {
          try_files \$uri \$uri/ /index.php?\$query_string;
      }
      location ~ \\.php$ {
          include snippets/fastcgi-php.conf;
          fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
      }
      location ~ /\\.ht {
          deny all;
      }
      error_log /var/log/nginx/laravel-worker_error.log;
      access_log /var/log/nginx/laravel-worker_access.log;
  }' > /etc/nginx/sites-available/laravel-worker

  ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/
  chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/

  service nginx restart
  service php8.0-fpm start
  ```

# Penjelasan Skrip Instalasi dan Konfigurasi Laravel

Skrip ini menjelaskan langkah-langkah untuk menginstal dan mengonfigurasi aplikasi Laravel, termasuk pengaturan lingkungan, migrasi database, dan konfigurasi server Nginx.

## Langkah-langkah Skrip

### 1. Kloning Repository Laravel
```
git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
mv laravel-praktikum-jarkom /var/www/laravel-praktikum-jarkom
```
### 2. Masuk ke Direktori dan Install Composer 
```
cd /var/www/laravel-praktikum-jarkom
composer update
composer install
```
### 3. Rename file .env.example menjadi .env dan tambahkan konfigurasi berikut
```
mv .env.example .env

echo "DB_CONNECTION=mysql" >> .env
echo "DB_HOST=192.243.2.1" >> .env
echo "DB_PORT=3306" >> .env
echo "DB_DATABASE=dbkelompokit20" >> .env
echo "DB_USERNAME=kelompokit20" >> .env
echo "DB_PASSWORD=passwordit20" >> .env
```
### 4. Menjalankan Migrasi Database
```
php artisan migrate:fresh
```
### 5. Menjalankan Seeder untuk Tabel Airings
```
php artisan db:seed --class=AiringsTableSeeder
```
### 6. Menghasilkan Kunci Aplikasi
```
php artisan key:generate
```
### 7. Menghasilkan Kunci JWT
```
php artisan jwt:secret
```
### 8. Membuat Symlink untuk Penyimpanan
```
php artisan storage:link
```
### 9. Menambahkan Konfigurasi Server Nginx
```
echo 'server {
    listen 8001;
    root /var/www/laravel-praktikum-jarkom/public;
    index index.php index.html index.htm;
    server_name _;
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    location ~ \\.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    }
    location ~ /\\.ht {
        deny all;
    }
    error_log /var/log/nginx/laravel-worker_error.log;
    access_log /var/log/nginx/laravel-worker_access.log;
}' > /etc/nginx/sites-available/laravel-worker
```
### 10. Mengaktifkan Konfigurasi Nginx
```
ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/
```
### 11. Mengubah Kepemilikan Direktori
```
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/
```
### 12. Memulai Ulang Nginx dan PHP-FPM
```
service nginx restart
service php8.0-fpm start
```
### Result
**Jessica**
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/01b0e88d-a6b8-4abf-97b6-35913d5bfeb5)
