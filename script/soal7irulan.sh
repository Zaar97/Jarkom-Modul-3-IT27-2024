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
