def prodVariables
def envRepoName = 'parking-dev-env-variables'

pipeline {
    agent any

    stages {
        stage('run services') {
            steps {
                sh 'docker-compose -f compose/main-infrastructure.yml --compatibility up -d'
            }
        }
        stage('get env variables') {
            steps {
                script {
                    checkout scm
                    withCredentials([sshUserPrivateKey(credentialsId: "github-ssh", keyFileVariable: 'key')]) {
                        sh 'rm -rf ${envRepoName}'
                        sh 'GIT_SSH_COMMAND="ssh -i $key"'
                        sh(
                                script: 'eval "$(ssh-agent)" && ssh-add $key && git clone "git@github.com:parkingology/${envRepoName}.git"',
                                returnStdout: true
                        ).trim()
                    }
                }
            }
        }

        stage('setup env addresses') {
            steps {
                script {
                    echo 'my file is: ' + "${envRepoName}/env/prod.yml"
                    prodVariables = readYaml file: "${envRepoName}/env/prod.yml"
                    echo prodVariables
                }
            }
        }


        stage('test if jeager is running') {
            steps {
                script {
                    def httpStatus = sh(
                            script: 'curl -s -o /dev/null -w \"%{http_code}\\n\" http://host.docker.internal:16686',
                            returnStdout: true
                    ).trim()
                    assert httpStatus == '200'
                }
            }
        }
    }

}
