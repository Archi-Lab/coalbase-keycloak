pipeline {
	agent any
	stages {
    stage('Build') {
        steps {
            updateGitlabCommitStatus name: "Building", state: "running"

            sh "docker build -t docker.nexus.archi-lab.io/archilab/coalbase-keycloak ."
            sh "docker tag docker.nexus.archi-lab.io/archilab/coalbase-keycloak docker.nexus.archi-lab.io/archilab/coalbase-keycloak:${env.BUILD_ID}"
            script {
                docker.withRegistry('https://docker.nexus.archi-lab.io//', 'archilab-nexus-jenkins-user') {
                    sh "docker push docker.nexus.archi-lab.io/archilab/coalbase-keycloak"
                }
            }
        }
        post {
            success {
                updateGitlabCommitStatus name: "Building", state: "success"
            }
            failure {
                updateGitlabCommitStatus name: "Building", state: "failed"
            }
            unstable {
                updateGitlabCommitStatus name: "Building", state: "success"
            }
        }
    }
		stage('Deploy') {
			steps {
				script {
          withCredentials([usernamePassword(credentialsId: 'CoalbaseKeycloak', usernameVariable: 'COALBASE_KEYCLOAK_USER', passwordVariable: 'COALBASE_KEYCLOAK_PASSWORD')]){
            docker.withRegistry('https://docker.nexus.archi-lab.io//', 'archilab-nexus-jenkins-user') {
              docker.withServer('tcp://10.10.10.25:2376', 'CoalbaseVM') {
                sh 'docker stack deploy -c ./docker-compose.yml -c ./docker-compose-prod.yml keycloak'
              }
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
