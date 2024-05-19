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
