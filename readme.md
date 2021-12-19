# build image that runs 3 mysql containers 
## steps to build and push 
    - docker build -t mysql_multi:1.0.0 .
    docker run -d --name mysql_container1 -p 8083:3006 -e MYSQL_ROOT_PASSWORD=root -v data-sql1:/var/lib/mysql -v /var/run/docker.sock:/var/run/docker.sock  mysql:8
    docker run -it --name test  --privileged=true -v /var/run/docker.sock:/var/run/docker.sock  mysql_multi:1.0.0
<span style="color:red"> - priviliged it should be true because to have permission to enable docker service </span>

<span style="color:red">- And we need to map volum /var/run/docker.sock to have ability to run docker inside docker </span>
## Folder data 
    contains data to be used by the instances