#!/bin/bash

# content-type
ContentType="Content-type:application/json"

# generate post data
sed -e "s/{name}/skanehira/" -e "s/{password}/neko/" -e "s/{description}/test/" template_user.json > user.json

# create user
echo "##### create user"
response=$(curl -s -X POST -H $ContentType -d @user.json http://localhost:8080/users) 
echo $response | jq 

# get id
id=`echo $response | jq . | grep id | awk '{print $2}' | cut -c 2-37`

# generate new post data
sed -e "s/{name}/PP/" -e "s/{password}/AP/" -e "s/{description}/PPAP/" template_user.json > user.json

# update user
echo "##### update user"
curl -s -X PUT -H $ContentType -d @user.json http://localhost:8080/users?id=$id | jq

# delete user
echo "##### delete user"
curl -s -X DELETE http://localhost:8080/users?id=$id | jq 

# get user
echo "##### get user id=[$id]"
curl -s http://localhost:8080/users?id=$id | jq 

