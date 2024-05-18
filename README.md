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
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 77](#soal-77)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)

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
	echo 'nameserver 192.168.122.1' > /etc/resolv.conf
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
	apt update
	apt install lynx -y
	apt install htop -y
	apt install apache2-utils -y
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

### Result

