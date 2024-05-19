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

- Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
- Client yang melalui House Harkonen mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 
- Client yang melalui House Atreides mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2 .200 - [prefix IP].2.210 
- Client mendapatkan DNS dari Princess Irulan dan dapat terhubung dengan internet melalui DNS tersebut 
- Durasi DHCP server meminjamkan alamat IP kepada Client yang melalui House Harkonen selama 5 menit sedangkan pada client yang melalui House Atreides selama 20 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit

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
wget -O '/var/www/harkonen.it27.com' 'https://drive.google.com/file/d/1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30/view?usp=sharing'
unzip -o /var/www/harkonen.it27.com -d /var/www/
rm /var/www/harkonen.it27.com
mv /var/www/modul-3 /var/www/harkonen.it27.com
```
