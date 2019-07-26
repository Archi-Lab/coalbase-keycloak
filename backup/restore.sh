#!/usr/bin/env bash

docker run --rm --network=keycloak_keycloak\
    --name keycloak_importer\
    -v $(pwd)/keycloak-export:/tmp/keycloak-export\
    -e DB_VENDOR=postgres\
    -e DB_ADDR=keycloak_db\
    -e DB_DATABASE=keycloak\
    -e DB_USER=keycloak\
    -e DB_PASSWORD=_CoalbaseKeycloak_2019\
    jboss/keycloak:4.8.3.Final\
    -Dkeycloak.migration.action=import\
    -Dkeycloak.migration.provider=dir\
    -Dkeycloak.migration.dir=/tmp/keycloak-export
    -Dkeycloak.migration.strategy.OVERWRITE_EXISTING
