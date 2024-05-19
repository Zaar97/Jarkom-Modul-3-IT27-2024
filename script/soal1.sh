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
