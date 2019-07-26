#!/usr/bin/env bash

# start service
docker-compose -p security \
  -f "./docker-compose.yml" \
  -f "./docker-compose-dev.yml" \
  down