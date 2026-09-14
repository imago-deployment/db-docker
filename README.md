## docker access control
### limit HOST_IP in the .env, such as
    - localhost
    - 0.0.0.0
<br>

## DB grant remote access permission
### mysql
1. basic info
    - username: root
    - db: backend_db
    - password: backend_2023_09_db
    - container name: mysql_3306
    - domain: mysql.db.imago.buzz

2. access to mysql docker
    - docker exec -it [container name] mysql -u [user name] -p
    ```
    docker exec -it mysql_3306 mysql -u root -p
    ```
    
    - check more
    ```
    show databases;
    select user, host from mysql.user;
    ```

3. create a new user with all permission
    ```sql
    CREATE USER 'admin'@'%' IDENTIFIED BY 'Imago@101';
    select user, host from mysql.user;
    GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
    FLUSH PRIVILEGES;
    ```
    ```
    select user, host from mysql.user;
    quit;
    ```

4. change mysql config
    edit the config file my.cnf and change setting.
    ```
    bind-address = 0.0.0.0
    ```
  
5. allow firewall
    ```
    ufw allow 3306/tcp
    ```
6. install and connect mysql by MySQLWorkbench locally

<br>

### mongodb
1. basic info
    - username: admin
    - password: backend_2023_09_db
    - container name: mongodb
    - domain: mongodb.db.imago.buzz

https://www.digitalocean.com/community/tutorials/how-to-configure-remote-access-for-mongodb-on-ubuntu-20-04

```
sudo lsof -i | grep mongo

sudo ufw allow from trusted_machine_ip to any port 27017
sudo ufw allow 27017/tcp
```

edit config file for docker
```
sudo nano mongodb/configdb/mongod.conf
```
add available IP address
bindIp: 127.0.0.1 ==> bindIp: 127.0.0.1, mongodb_server_ip

** test **

```
curl -4 icanhazip.com
```

```
nc -zv 157.230.225.136 27017
```

```
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1, 192.241.147.40
```

### redis
1. basic info
    - password: backend_2023_09_db
    - container name: redis
    - domain: redis.db.imago.buzz

2. access remotely
use correct version's redis configuration
redis.conf download link: https://redis.io/docs/latest/operate/oss_and_stack/management/config/
```
cd ./config/redis/config/
cp v8.8-redis.conf redis.conf
rm v7.7-redis.conf v8.8-redis.conf
```
change the configuration
```
bind 0.0.0.0
```

### postgres
1. basic info
    - username: admin
    - password: backend_2023_09_db
    - container name: postgres
    - domain: postgres.db.imago.buzz
2. customize configuration
    - get configuration sample
      ```
      docker exec -it postgres sh
      ls -al /usr/share/postgresql/postgresql.conf.sample
      exit
      ```
    - download postgresql.conf
      ```
      docker run -i --rm postgres:17 cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf
      ```
    - download pg_hba.conf
      ```
      docker run -i --rm postgres:17 cat /usr/share/postgresql/17/pg_hba.conf.sample > pg_hba.conf
      ```
    
    - boot Postgres using the mounted configuration file
    - refer: 
      - https://docs.docker.com/guides/postgresql/
      - https://deepwiki.com/docker-library/postgres/4.3-configuration-and-customization
      - https://www.postgresql.org/docs/current/storage-file-layout.html
      </br>
      `
      Traditionally, the configuration and data files used by a database cluster are stored together within the cluster's data directory, commonly referred to as PGDATA (after the name of the environment variable that can be used to define it). A common location for PGDATA is /var/lib/pgsql/data. Multiple clusters, managed by different server instances, can exist on the same machine.
      `
      </br></br>
      `
      The PGDATA directory contains several subdirectories and control files, as shown in Table 66.1. In addition to these required items, the cluster configuration files postgresql.conf, pg_hba.conf, and pg_ident.conf are traditionally stored in PGDATA, although it is possible to place them elsewhere.
      `
      </br></br>
      `
      search and refer `FILE LOCATIONS` in the postgresql.conf 
      `

3. access remotely
    - modify postgresql.conf
      ```
      listen_addresses = '*'
      ```
    - modify pg_hba.conf
      ```
      host    all             all             0.0.0.0/0               scram-sha-256
      ```
    - adjust firewall
      ```
      sudo ufw allow 5432/tcp
      ```
    - modify port in docker-compose
      ```
      - "5432:5432"
      ```
    - reboot docker

