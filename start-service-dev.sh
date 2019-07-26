#!/usr/bin/env bash
CURRENT=$(pwd)

# pull service
docker-compose \
  -f "$CURRENT/docker-compose.yml" \
  -f "$CURRENT/docker-compose-dev.yml" \
  pull
  
# start service
docker-compose -p security \
  -f "$CURRENT/docker-compose.yml" \
  -f "$CURRENT/docker-compose-dev.yml" \
  up -d