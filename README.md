User Request (HTTPS)
         |
         v
+---------------------+
|      Internet       |
+---------------------+
         |
         v
+---------------------+
|       Nginx         |  Listens port 443 (HTTPS)
|  (SSL termination)  |----------------------------+
+---------------------+                            |
         |                                         v
         v                                +-----------------+
+---------------------+                   |                 |
|     Nginx           |                   |    Redis        |
|    internal         |                   |                 |
|   (HTTP Proxy)      |------------------>|    Cache        |
+---------------------+                   |    (Memory)     |
         |                                |                 |
         v                                +-----------------+
+----------------------+
|    WordPress         |
|    Container         |
|    (PHP-FPM)         |
|  Listens port 9000   |-----------------+
+----------------------+                 |
         |                               v
         v                      +-----------------+
+---------------------+         |                 |
|   MariaDB           |<--------|    WordPress    |
|   Container         |         |  (Database)     |
|   (Database)        |         |                 |
+---------------------+         +-----------------+



check that redis is being used in the container
```bash
docker exec -it wordpress-redis redis-cli
KEYS *


```