#!/bin/bash

# content-type
ContentType="Content-type:application/json"

# generate user data
sed -e "s/{name}/skanehira/" -e "s/{password}/neko/" template_user.json > user.json

# create user
echo "##### create user"
response=$(curl  -s -X POST -H $ContentType -d @user.json http://localhost:8080/users) 
echo $response | jq 

# get user id
userid=`echo $response | jq . | grep id | awk '{print $2}' | cut -c 2-37`

echo "##### get user id=[$userid]"
curl  -s http://localhost:8080/users/$userid | jq 

# generate memo data
sed -e "s/{userid}/$userid/" -e "s/{title}/test1/" -e "s/{text}/test1/" template_memo.json > memo.json

# create memo
echo "#### create memo"
response=$(curl  -s -X POST -H $ContentType -d @memo.json http://localhost:8080/memos) 
echo $response | jq 

# get memo
memoid=`echo $response | jq . | grep id | awk '{print $2}' | cut -c 2-37`
echo "#### get memo"
curl  -s http://localhost:8080/memos/$userid | jq 

# generate new memo data
sed -e "s/{userid}/$userid/" -e "s/{title}/testssssssssssssss1/" -e "s/{text}/tedddsdfafdafdaft1/" template_memo.json > memo.json
echo "#### update memo"
response=$(curl  -s -X PUT -H $ContentType -d @memo.json http://localhost:8080/memos/$userid/$memoid) 
echo $response | jq 

# generate new user data
sed -e "s/{name}/PP/" -e "s/{password}/AP/" template_user.json > user.json

# update user
echo "##### update user"
cat user.json | jq
curl  -s -X PUT -H $ContentType -d @user.json http://localhost:8080/users/$userid | jq

# update password
echo "#### update password"
sed -e "s/{password}/testestetset/" template_password.json > password.json
cat password.json | jq
curl -s -X PUT -H $ContentType -d @password.json http://localhost:8080/users/$userid/password | jq
curl -s http://localhost:8080/users/$id | jq 

# delete user
echo "##### delete user"
curl  -s -X DELETE http://localhost:8080/users/$userid | jq 

# get user
echo "##### get user id=[$userid]"
curl  -s http://localhost:8080/users/$userid | jq 

