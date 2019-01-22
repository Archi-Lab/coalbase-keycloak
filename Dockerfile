FROM jboss/keycloak:4.8.3.Final

EXPOSE 8080
COPY realmconfig/coalbase-realm.json realmconfig/coalbase-realm.json

