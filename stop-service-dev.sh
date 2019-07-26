#!/usr/bin/env bash
CURRENT=$(pwd)

# start service
docker-compose -p security \
  -f "$CURRENT/docker-compose.yml" \
  -f "$CURRENT/docker-compose-dev.yml" \
  down