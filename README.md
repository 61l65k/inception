User Request (HTTPS)
         |
         v
+---------------------+
|      Internet       |
+---------------------+   
         |
       ROUTER 
         |
         |
       COMPUTER
         |
         |                                  
        UFW <----------------------21---------------------> +-----------container------------+
         |                                                  |                                |
         |                                                  |     FTP Server (vsftpd)        |
         v                                                  |                                | 
+-----container-------+                                     |                                |
|       Nginx         |                                     |  Listens on port 21            |
|   Port 443 (HTTPS)  |                                     |  Passive ports 21100-21110     |
|  (SSL termination)  |                                     |                                |
+---------------------+                                     +--------------------------------+
         |                                                                  ^         
         |                    +----container----+                           |
         |                    |                 |                           |
         9                    |    Redis        |                           |
         0<-------6379--------|                 |                           |           
         0--------6379------->|    Cache DB     |                           |
         0                    |                 |                           |
         |                    |                 |                           |
         v                    +-----------------+                           |
+-------container------+                                                    |
|                      |            +------volume--------+                  |
|    WordPress         |----------->|                    |                  |
|                      |            | wordpress volume   |<------------------
|    PHP-FPM: 9000     |<-----------| www/html (website) |
|                      |            +--------------------+ -- (attached to host remembering)
+----------------------+                
         |  ^
         |  |
         3  3
         3  3 
         0  0
         6  6
         |  |
         |  |
         v  |
+------container------+            +------volume-----+         
|                     |----------->|                 |
|      MariaDB        |            | mariadb volume  |    
|                     |<-----------|                 |    
+---------------------+            +-----------------+ -- (attached to host remembering)
                               

Actual Network: Nginx, FTP                               
Docker network: WordPress, Redis, MariaDB
                               
                               




check that redis is being used in the container and stores keys
```bash
docker exec -it wordpress-redis redis-cli
KEYS *


```

connect ot ftp server running on localhost:21  user.42.fr