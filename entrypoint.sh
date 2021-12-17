#!/bin/bash

echo "STEP [1] Installing apt ca-cerificates curl ..."
apt install -y apt-transport-https ca-certificates curl software-properties-common
echo "Done..."
echo "STEP [2] Curl docker for ubuntu and add key ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo "Done..."
echo "STEP [3] Add repository and update..."
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test"
apt update
echo "Done..."
echo "STEP [4] Install docker..."
apt install -y docker-ce
echo "Done..."
echo "STEP [5] Create data folders for instances of mysql"
mkdir data-sql1 data-sql2 data-sql2
echo "STEP [6] Copy data to 3 volumes that will be mapped with var/lib/mysql to duplicate data"
cp -a /DATA/. /data-sql1/
cp -a /DATA/. /data-sql2/
cp -a /DATA/. /data-sql3/
echo "Done..."
echo "STEP [6] Start docker service..."
service docker start
echo "Done..."
echo "STEP [7] Run the first container exposed at port 8083..."
docker run -d --name mysql_container1 -p 8083:3006 -e MYSQL_ROOT_PASSWORD=root -v data-sql1:/var/lib/mysql -v /var/run/docker.sock:/var/run/docker.sock  mysql:8
echo "STEP [8] Run the second container mapped at port 8084..."
docker run -d --name mysql_container2 -p 8084:3006 -e MYSQL_ROOT_PASSWORD=root -v data-sql2:/var/lib/mysql -v /var/run/docker.sock:/var/run/docker.sock  mysql:8
echo "STEP [9] Run the third container mapped at port 8085..."
docker run -d --name mysql_container3 -p 8085:3006 -e MYSQL_ROOT_PASSWORD=root -v data-sql3:/var/lib/mysql -v /var/run/docker.sock:/var/run/docker.sock  mysql:8
echo "Done"
exec tail -f /dev/null

