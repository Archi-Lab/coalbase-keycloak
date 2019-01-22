FROM jboss/keycloak:4.8.3.Final

EXPOSE 8080
COPY ./realmconfig/* /realmconfig/*

