University: [ITMO University](https://itmo.ru/ru/)  
Faculty: [FICT](https://fict.itmo.ru)  
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)  
Year: 2025/2026  
Group: K3323  
Author: Ivanova Ekaterina Andreevna  
Lab: Lab1  
Date of creation: 07.09.2025  
Date of finish:  

## Laboratory Work No. 1: "Installing ContainerLab and Deploying a Test Communication Network"

### Helpful sources

- [Simple deployment of a container-based network lab](https://habr.com/ru/articles/682974/)

### Objective

Become familiar with the ContainerLab tool, study the operation of VLANs, IP addressing, and related concepts

### Tasks

  1. Build a three-tier enterprise communication network in ContainerLab
  2. Configure IP addresses on interfaces and set up two VLANs on the PC
  3. Create two DHCP servers on the central router within the previously created VLANs to distribute IP addresses
  4. Configure device hostnames and change logins and passwords

### Procedure

#### Preliminary Setup

- Install `Docker` and start an engine
  [Manual for Ubuntu](https://docs.docker.com/engine/install/ubuntu/)  

- Install `make`

    ```commandline
    sudo apt install make
    make --version
    ```

- Clone `hellt/vrnetlab`

    ```commandline
    git clone https://github.com/srl-labs/vrnetlab.git
    ```

- Copy to `vrnetlab/mikrotik/routeros` VDM with MikroTik RouterOS

    ```commandline
    scp ~/Downloads/chr-6.47.9.vmdk ~/vrnetlab/mikrotik/routeros
    ```

- Create an image

    ```commandline
    make docker-image
    ```

- Install ContainerLab

    ```commandline
    curl -sL https://containerlab.dev/setup | sudo -E bash -s "all"
    ```

- To enable sudo-less docker command execution run

    ```commandline
    newgrp docker
    ```

#### Main part

It is required to build a three-tier enterprise network, as shown in Picture 1, using ContainerLab

![](./images/3tiernetwork.png)

### Базовая конфигурация

Для начала напишем базовый *.clab.yml файл, где создадим наши устройства и укажем связи между ними

```commandline
name: tplg1

topology:
 nodes:
  R01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
  
    SW01.L3.01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
   
  SW02.L3.01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
   
  SW02.L3.02.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
   
  PC1:
   kind: linux
   image: alpine:latest
   
  PC2:
   kind: linux
   image: alpine:latest
   
 links:
  - endpoints: ["R01.TEST:eth1", "SW01.L3.01.TEST:eth1"]
  - endpoints: ["SW01.L3.01.TEST:eth2", "SW02.L3.01.TEST:eth1"]
  - endpoints: ["SW01.L3.01.TEST:eth3", "SW02.L3.02.TEST:eth1"]
  - endpoints: ["SW02.L3.01.TEST:eth2", "PC1:eth1"]
  - endpoints: ["SW02.L3.02.TEST:eth2", "PC2:eth1"]
```

Созданы 4 контейнера типа vr-ros на базе скачанного ранее образа, а также 2 ПК на базе alpine
Дополнительно указаны связи между всеми устройствами согласно схеме из задания

### Создание mgmt-сети

mgmt-сеть (managed network) - это изолированная вспомогательная сеть управления, через которую мы будем подключаться к нашим контейнерам

Пропишем каждому устройству его статический ipv4-адрес:

```commandline
 nodes:
  R01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt_ipv4: 172.20.20.11
  
    SW01.L3.01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt_ipv4: 172.20.20.21
   
  SW02.L3.01.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt_ipv4: 172.20.20.31
   
  SW02.L3.02.TEST:
   kind: vr-ros
   image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt_ipv4: 172.20.20.32
   
  PC1:
   kind: linux
   image: alpine:latest
      mgmt_ipv4: 172.20.20.41
   
  PC2:
   kind: linux
   image: alpine:latest
      mgmt_ipv4: 172.20.20.42
```

Попробуем задеплоить нашу сеть командой `clab deploy -t tplg1.clab.yml`

Получаем WARNING 
```commandline
15:57:11 WARN Node name will not resolve via DNS name=clab-tplg1-R01.TEST reason="name contains invalid characters such as '.' and/or '_'"
15:57:11 WARN Node name will not resolve via DNS name=clab-tplg1-SW01.L3.01.TEST reason="name contains invalid characters such as '.' and/or '_'"
15:57:11 WARN Node name will not resolve via DNS name=clab-tplg1-SW02.L3.01.TEST reason="name contains invalid characters such as '.' and/or '_'"
15:57:11 WARN Node name will not resolve via DNS name=clab-tplg1-SW02.L3.02.TEST reason="name contains invalid characters such as '.' and/or '_'"
```

Переименуем наши ноды, убрав точки и снова задеплоим нашу сеть 
```commandline
sudo containerlab destroy -t tplg1.clab.yml
sudo containerlab deploy -t tplg1.clab.yml
```

Проверим состояние сети
```commandline
sudo containerlab inspect -t tplg1.clab.yml 
```
![](./images/p1.png)

### Настройка конфигураций

Для каждого устройства создадим конфиг файл

Для R01:

- Смена имени устройства, логина и пароля:
  
  ```commandline
  /system identity set name=R01 # задаем имя устройства
  /user set 0 name=kate password=123 # изменяем креды встроенного пользователя
  ```

- VLAN-интерфейсы и ip адреса на них

  ```commandline
  /interface vlan
  add name=vlan10 interface=eth2 vlan-id=10
  add name=vlan20 interface=eth3 vlan-id=20

  /ip address
  add address=192.168.10.1/24 interface=vlan10
  add address=192.168.20.1/24 interface=vlan20
  ```

- DHCP серверы и диапазоны адресов

  ```commandline
  /ip pool # определяем диапазоны адресов, которые будут раздаваться
  add name=pool_vlan10 ranges=192.168.10.10-192.168.10.100 
  add name=pool_vlan20 ranges=192.168.20.10-192.168.20.100

  /ip dhcp-server # создаем dhcp-серверы на каждом VLAN
  add name=dhcp_vlan10 interface=vlan10 address-pool=pool_vlan10
  add name=dhcp_vlan20 interface=vlan20 address-pool=pool_vlan20

  /ip dhcp-server enable dhcp_vlan10 # активируем dhcp-сервера
  /ip dhcp-server enable dhcp_vlan20
  ```

Для SW01:

- Смена имени устройства, логина и пароля:
  
  ```commandline
  /system identity set name=SW01
  /user set 0 name=kate password=123
  ```

Добавим `startup-config` в файл с топологией и пересоберем сеть командой 
```commandline
sudo containerlab redeploy -t tplg1.clab.yml 
```
![](./images/p2.png)

#### Conclusion
