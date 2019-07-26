#!/usr/bin/env bash

mkdir keycloak-export
chmod ugo=rwx keycloak-export
docker run --rm --network=keycloak_keycloak\
  --name keycloak_exporter\
  -v $(pwd)/keycloak-export:/tmp/keycloak-export\
  -e DB_VENDOR=postgres\
  -e DB_ADDR=keycloak_db\
  -e DB_DATABASE=keycloak\
  -e DB_USER=keycloak\
  -e DB_PASSWORD=_CoalbaseKeycloak_2019\
  jboss/keycloak:4.8.3.Final\
  -Dkeycloak.migration.action=export\
  -Dkeycloak.migration.provider=dir\
  -Dkeycloak.migration.dir=/tmp/keycloak-export
