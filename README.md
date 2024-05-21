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
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)

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

### Script

```bash
echo 'nameserver 10.77.3.2' > /etc/resolv.conf

apt-get update
apt-get install nginx -y
apt-get install lynx -y
apt-get install php php-fpm -y
apt-get install wget -y
apt-get install unzip -y
service nginx start
service php7.3-fpm start

wget -O '/var/www/harkonen.it27.com' 'https://drive.usercontent.google.com/u/0/uc?id=1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30&export=download'
unzip -o /var/www/harkonen.it27.com -d /var/www/
rm /var/www/harkonen.it27.com
mv /var/www/modul-3 /var/www/harkonen.it27.com

source /root/script.sh
/root/script.sh
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
         fastcgi_pass unix:/run/php/php7.3-fpm.sock;
         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
         include fastcgi_params;
     }
 }' > /etc/nginx/sites-available/harkonen.it27.com

 service nginx restart
```

Lalu jalankan bash script dengan `source /root/.bashrc`

### Testing Result

Jalanin Perintah `lynx localhost` pada masing-masing worker dan hasilnya akan sebagai berikut:
![Screenshot 2024-05-19 174238](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/c42b039a-980d-4b10-b28b-692a2923e44c)

![Screenshot 2024-05-19 173908](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/07d4e7b9-2e96-43b1-98ca-39354d6e2cc3)

![Screenshot 2024-05-19 174024](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/5e87272a-ae73-46d6-b0c2-3ab936a05893)


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
@       IN      AAAA    ::1' > /etc/bind/jarkom/atreides.it27.com

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
@       IN      AAAA    ::1' > /etc/bind/jarkom/harkonen.it27.com
```

`@       IN      A       10.77.4.2` disini IP diarahkan ke node Load Balancer Stilgar

Lalu kembali ke node `Stilgar` dan lakukan Konfigurasi `/root/.bashrc` untuk nginx sebagai berikut

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

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
```

### Testing Result

Jalankan perintah berikut pada client

```bash
ab -n 5000 -c 150 http://www.harkonen.it27.com/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/12ad432b-2212-4512-8eec-bad67d179bb1)

Dapat dilihat, request tersebut menghasilkan `Requests per second:    1096.80 [#/sec] (mean)`

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

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
```

### Testing

**Round Robin**

```bash
ab -n 500 -c 50 http://harkonen.it27.com/roundrobin/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/28a1fe8e-4f60-44e4-9b08-d51c5863ca1d)


Dapat dilihat, request tersebut menghasilkan `Requests per second:    969.68 [#/sec] (mean)`

**Least Connection**

```bash
ab -n 500 -c 50 http://harkonen.it27.com/leastconn/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/a570494a-80f8-4adf-ad39-ad15b67806d9)


Dapat dilihat, request tersebut menghasilkan `Requests per second:    1085.55 [#/sec] (mean)`

**Weighted Round Robin**

```bash
ab -n 500 -c 50 http://harkonen.it27.com/weightedrr/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/1de6b06d-cfef-4fa8-82db-cd5ef9a19210)


Dapat dilihat, request tersebut menghasilkan `Requests per second:    1230.03 [#/sec] (mean)`

**IP Hash**

```bash
ab -n 500 -c 50 http://harkonen.it27.com/iphash/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/3ec4efc5-ff39-49bb-a6b1-96a4c61de5f7)


Dapat dilihat, request tersebut menghasilkan `Requests per second:    1330.95 [#/sec] (mean)`

**Generic Hash**

```bash
ab -n 500 -c 50 http://harkonen.it27.com/hash/
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/a90aae55-bba6-4f36-aa3e-85bb5d809079)

Dapat dilihat, request tersebut menghasilkan `Requests per second:    1160.04 [#/sec] (mean)`

### Analisis

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/5277ee5a-3e5b-4523-a43f-a8b46d66be46)

Round Robin memiliki proses request tercepat

## Soal 9

> Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta

Setelah melakukan setup pada node Stilgar sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan 1 worker, 2 worker, dan 3 worker.

Jalankan command berikut pada client

```bash
ab -n 1000 -c 10 http://www.harkonen.it27.com/leastconn/
```

### Result

**3 Worker**

```bash
upstream leastconn_worker {
    least_conn;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/117ff269-664d-41ac-a322-aa1bd62d2b55)

Dapat dilihat, request tersebut menghasilkan `Requests per second:    834.54 [#/sec] (mean)`

**2 Worker**

```bash
upstream leastconn_worker {
    least_conn;
    # server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/8384d039-1a1a-40a4-a446-1953ae74f129)

Dapat dilihat, request tersebut menghasilkan `Requests per second:     973.39 [#/sec] (mean)`

**1 Worker**

```bash
upstream leastconn_worker {
    least_conn;
    # server 10.77.1.1;
    # server 10.77.1.2;
    server 10.77.1.3;
}
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/0eff4209-c5f3-4eb6-859b-caa866dd0db6)

Dapat dilihat, request tersebut menghasilkan `Requests per second:     1118.56 [#/sec] (mean)`

### Grafik

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/8f57b3da-8744-46a1-937e-1528851b4030)

1 Worker memiliki waktu request terlama.

## Soal 10
> Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di LB dengan dengan kombinasi username: “secmart” dan password: “kcksyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/

### Script

**Stilgar**

Membuat folder supersecret 
```bash
mkdir /etc/nginx/supersecret 
htpasswd -c /etc/nginx/supersecret/htpasswd secmart 
```

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/a73490a5-eab9-4e71-a005-32c7d154e61e)

`password = kcksit27`

Mengubah konfigurasi nginx
```bash
auth_basic "Restricted Content";
auth_basic_user_file /etc/nginx/supersecret/htpasswd;
```

```bash
mkdir -p /etc/nginx/supersecret

htpasswd -bc /etc/nginx/supersecret/htpasswd secmart kcksit27

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
    	auth_basic "Restricted Content";
    	auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
	}
    
}' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
#rm /etc/nginx/sites-enabled/default

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
```

## Soal 11
Lalu buat untuk setiap request yang mengandung /dune akan di proxy passing menuju halaman https://www.dunemovie.com.au/. **hint: (proxy_pass)**

```bash
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
    
    location ~ /dune {
    	rewrite ^/dune(.*)$ /$1 break;
     	proxy_pass https://www.dunemovie.com.au/;
    	proxy_set_header Host www.dunemovie.com.au;
    	proxy_set_header X-Real-IP $remote_addr;
    	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    	proxy_set_header X-Forwarded-Proto $scheme;

      	break;
       }
	
    location / {
        proxy_pass http://worker;   
    	auth_basic "Restricted Content";
    	auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
	}
    
}' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
#rm /etc/nginx/sites-enabled/default

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
```

## Soal 12
Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.37, [Prefix IP].1.67, [Prefix IP].2.203, dan [Prefix IP].2.207. **hint: (fixed in dulu clientnya)**

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
echo "DB_HOST=10.77.4.1" >> .env
echo "DB_PORT=3306" >> .env
echo "DB_DATABASE=dbkelompokit27" >> .env
echo "DB_USERNAME=kelompokit27" >> .env
echo "DB_PASSWORD=passwordit27" >> .env
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
**Jessica** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/01b0e88d-a6b8-4abf-97b6-35913d5bfeb5)

## Soal 15-17
> atreides Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada peta.

- Lakukan installasi juga untuk package yang diperlukan untuk benchmarking seperti Apache Benchmark dan Htop

```
apt-get update
apt-get install lynx -y
apt-get install htop -y
apt-get install apache2-utils -y
apt-get install jq -y
```

- Buat file `cred.json` yang digunakan untuk menyimpan credentials yang dibuat sebelumnya

```
{
  "username": "kelompokit27",
  "password": "passwordit27"
}
```

### 15. POST /auth/register

- Testing dilakukan sebanyak 100 kali request dengan frekuensi 10 request/s

```
ab -n 100 -c 10 -p cred.json -T application/json http://10.77.2.1:8001/api/auth/register
```

**Result** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/c6aca088-6756-41ee-8c8a-069c43661425)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/ea3bdfae-64b4-4e99-b6d0-51dfc3e8185f)

### 16. POST /auth/login
- Testing dilakukan sebanyak 100 kali request dengan frekuensi 10 request/s

```
ab -n 100 -c 10 -p cred.json -T application/json http://10.77.2.1:8001/api/auth/login
```
**Result** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/6503eb0a-9674-41ab-b751-2e16d6bb93ca)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/c428a630-3858-432f-947c-c591a5dce2af)

### 17. GET /me
- Testing dilakukan sebanyak 100 kali request dengan frekuensi 10 request/s

```
ab -n 100 -c 10 -p cred.json -T application/json http://10.77.2.1:8001/api/auth/me
```
**Result** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/8273002e-65c8-4b17-9051-3290457ce1a0)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/03544fbf-ea4d-4ed0-ba5d-1551264fd4a1)

## Soal 18
> Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur atreides Channel maka implementasikan Proxy Bind pada Stilgar untuk mengaitkan IP dari Leto, Duncan, dan Jessica

- #### Arahkan Nameserver ke DNS Server 
```
echo 'nameserver 10.77.3.2' > etc/resolv.conf
```
- #### Konfigurasi ulang Bind di Irulan
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it27.com. root.atreides.it27.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it27.com.
@       IN      A       10.77.4.2     ; IP Stilgar (Load Balancer)
www     IN      CNAME   atreides.it27.com.
```
- #### Lakukan Konfigurasi pada File /etc/nginx/sites-available/laravel-worker pada Load Balancer
```
upstream worker {
    server 10.77.2.1:8001;
    server 10.77.2.2:8002;
    server 10.77.2.3:8003;
}
server {
    listen 80;
    server_name atreides.it27.com www.atreides.it27.com;

    location / {
        proxy_pass http://worker;
    }
}
```
- #### Buat Symbol Link dan Restart Nginx
```
ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart
```
- ### Testing
```
ab -n 100 -c 10 -p cred.json -T application/json http://atreides.it27.com/api/auth/login
```
### Result <br>
** Benchmarking dilakukan tidak lagi dengan port, tetapi dengan domain**
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/28df8c5e-ebf6-4d8c-9943-45b3c573e25f)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/293a45ce-d0a0-4660-b20a-3e421b527ca1)

**3 Worker Sudah Balance** <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/9c1fc57e-b6c9-4c2b-9382-3d9946386543)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/e8786fd7-403d-470c-a91c-3bf4027f1f4d)
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/d0ff57d4-caa3-4b8d-a5d7-d6acbd55871c)

## Soal 19
> Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur atreides Channel maka implementasikan Proxy Bind pada Stilgar untuk mengaitkan IP dari Leto, Duncan, dan Jessica
Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Leto, Duncan, dan Jessica. Untuk testing kinerja naikkan:
- pm.max_children
- pm.start_servers
- pm.min_spare_servers
- pm.max_spare_servers
sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada PDF

- Untuk Mengubah Parameter - Parameter Tersebut akses file `/etc/php/8.0/fpm/pool.d/www.conf`. Di sini saya akan menggunakan script untuk mengubah file
- v1.sh
```
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 5
pm.start_servers = 1
pm.min_spare_servers = 1
pm.max_spare_servers = 3' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```
- v2.sh
```
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 25
pm.start_servers = 5
pm.min_spare_servers = 5
pm.max_spare_servers = 10' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart  
```
- v3.sh
```
# Setup Awal
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart  
```

- Testing Command masih sama dengan soal 18
- Gunakan htop untuk melihat perubahannya
### Result v1 <br>
- Leto<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/04cee005-6696-48b1-82b3-ad1d6898f5ea)
- Duncan<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/7809d589-a4ca-4775-a2c3-a848985ad80d)
- Jessica<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/df511d64-f397-4125-92ef-87f636cd4ed1)

### Result v2
- Leto<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/6b4dd320-90c9-46ba-a29c-aaea688fbb97)
- Duncan<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/b568036b-ca1c-4b4e-8b05-485f4a2b39bf)
- Jessica<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/a84c71bb-5128-493b-87a1-2c51982cb08b)

### Result v3
- Leto<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/f2817fef-4707-45ad-ae56-2f5ab9801eec)
- Duncan<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/84556448-ae04-428a-a7e5-06d6a1b041bc)
- Jessica<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/932ccf72-ac59-4184-99a8-e692dfcb2038)

## Soal 20
> Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Stilgar. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.

- Caranya cukup sederhana, yakni dengan menambahkan "least_conn;" pada `/etc/nginx/sites-available/laravel-worker`
```
upstream worker {
    least_conn
    server 10.77.2.1:8001;
    server 10.77.2.2:8002;
    server 10.77.2.3:8003;
}
server {
    listen 80;
    server_name atreides.it27.com www.atreides.it27.com;

    location / {
        proxy_pass http://worker;
    }
}
```
- Kemudian testing ulang dengan command yang sama
```
ab -n 100 -c 10 -p cred.json -T application/json http://atreides.it27.com/api/auth/login
```
### Result
- Leto <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/e4948a6a-5a81-4f90-bff7-7de5a9a5cde0)  
- Duncan <br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/d12ee29d-aca7-4297-b8ea-f4e892857ac4)
- Jessica<br>
![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/136430870/e3474104-42db-4d5e-928c-3e8d8ea2bbef)
