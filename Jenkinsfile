pipeline {
	agent any
	stages {
		stage('Deploy') {
			steps {
				script {
          withCredentials([usernamePassword(credentialsId: 'CoalbaseKeycloak', usernameVariable: 'COALBASE_KEYCLOAK_USER', passwordVariable: 'COALBASE_KEYCLOAK_PASSWORD')]){
            docker.withServer('tcp://10.10.10.25:2376', 'CoalbaseVM') {
              sh 'docker stack deploy -c ./docker-compose.yml -c ./docker-compose-prod.yml keycloak'
            }
					}
				}
			}
			post {
				success {
					updateGitlabCommitStatus name: "Running", state: "success"
				}
				failure {
					updateGitlabCommitStatus name: "Running", state: "failed"
				}
				unstable {
					updateGitlabCommitStatus name: "Running", state: "failed"
				}
			}
		}
	}
}
