#!/usr/bin/env bash

# pull service
docker-compose \
  -f "./docker-compose.yml" \
  -f "./docker-compose-dev.yml" \
  pull
  
# start service
docker-compose -p security \
  -f "./docker-compose.yml" \
  -f "./docker-compose-dev.yml" \
  up -d