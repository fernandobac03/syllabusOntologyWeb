#!/bin/bash


docker stop ontoweb
docker rm ontoweb
docker rmi ontoweb
docker build -t ontoweb .
