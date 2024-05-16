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

![image](https://github.com/Zaar97/Jarkom-Modul-3-IT27-2024/assets/128958228/106866e6-0b7a-435f-86b5-efe64f459b36)

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
	    address 10.77.1.1
	    netmask 255.255.255.0
	    gateway 10.77.1.0
    ```

- **DNS Server**
  - Irulan
      ```bash
      
      ```

- **Database Server**
  - Chani
      ```bash
      
      ```

- **Load Balancer**
  - Stilgar
      ```bash
      
      ```

- **Laravel Worker**
  - Leto
      ```bash
      
      ```

  - Jessica
      ```bash
      
      ```

  - Duncan
      ```bash
      
      ```

- **PHP Worker**
  - Vladimir
      ```bash
      
      ```

  - Rabban
      ```bash
      
      ```

  - Feyd
      ```bash
      
      ```

- **Client**
  - Dmitri
      ```bash
      
      ```

  - Paul
      ```bash
      
      ```
## Prerequisite
