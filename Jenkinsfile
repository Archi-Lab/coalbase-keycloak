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
                    // docker.withServer('tcp://10.10.10.25:2376', 'CoalbaseVM') {
                        docker.withRegistry('https://docker.nexus.archi-lab.io//', 'archilab-nexus-jenkins-user') {
                            withCredentials([usernamePassword(credentialsId: 'CoalbaseKeycloak', usernameVariable: 'COALBASE_KEYCLOAK_USER', passwordVariable: 'COALBASE_KEYCLOAK_PASSWORD')]) {
                                sh 'docker stack deploy --with-registry-auth -c ./docker-compose.yml -c ./docker-compose-prod.yml keycloak'
                            }
                        }
                    // }
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
    post {
        failure {
            discordSend description: 'Jenkins Pipeline Build', footer: 'CoalBase-KeyCloak', link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: 'https://discordapp.com/api/webhooks/537602034015272960/9qa_bwMs5ZVuntNCg3BmHXYSDgo9gPZjHrgxsPJG8xya3hesFpm2aiAu8VcO3yNG9r59'
        }
    }
}
