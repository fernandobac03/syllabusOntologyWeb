#!/bin/bash

docker stop ontoweb
docker rm ontoweb
docker run -d --name ontoweb -p 8081:8081 ontoweb
