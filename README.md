# coalbase-keycloak

## Keycloak aufsetzen
1. Um eine Keycloak Instanz zu erhalten können entweder die Docker-Compose Files direkt oder das Setup-Script aus dem Repository genutzt werden. Im Gegensatz zu Docker-Compose wird hierbei eine Docker Swarm Umgebung genutzt. Dabei kann es sein, dass vorher zuerst einmal eine Docker Swarm Umgebung mittels “docker swarm init” erzeugt werden muss.

2. Um Keycloak zu konfigurieren, kann auf die Admin-Konsole unter der URL http://localhost:8090/auth/ unter dem Menüpunkt “Administration Console” zugegriffen werden.

3. Bevor Rollen und Clients eines Realms importiert werden können, muss vorher der Realm “Coalbase” angelegt werden.

4. Nun kann der Realm unter “Import” importiert werden. Die Json-Datei ist unter der URL https://www.archi-lab.io/display/COAL/CoalBase+-+Rebuild zu bekommen.

5. Zum Testen kann nun ein Account unter “Users/Add User” angelegt werden. Diesem User müssen nun die Rollen “coalbase_professor”, “offline_access” und “uma_authorization” zugeteilt werden.

## Troubleshooting
* Falls das Keycloak Image von Docker nicht bezogen werden kann, muss dies vorher von einer eigenen Docker Registry aus bezogen werden. Nachdem man sich mit “docker login docker.nexus.archi-lab.io” eingeloggt hat, kann das Image mit “docker pull docker.nexus.archi-lab.io/archilab/coalbase-keycloak” heruntergeladen werden.

* Ein in Keycloak definierter User braucht unbedingt die Rolle “view-profiles”, damit dieser erfolgreicht eingeloggt werden kann. Dies ist eine für den Client “account” definierte Rolle, welche bei der Erstellung eines neuen Users zugeordnet wird, wenn dies unter “Roles/Default Roles/Client Roles” konfiguriert wurde. Notfalls kann diese Rolle auch einem einzelnen User unter “Users/<User>/Role Mappings/Client Roles” zugewiesen werden.
