pipeline {
    agent any

    stages {
        stage('run services') {
            steps {
                sh 'docker-compose -f compose/main-infrastructure.yml --compatibility up -d'
            }
        }
        stage('test if jeager is running') {
            steps {
                script {
                    checkout scm
                    withCredentials([sshUserPrivateKey(credentialsId: "github-ssh", keyFileVariable: 'key')]) {
                        sh 'rm -rf envvars && mkdir envvars && cd envvars'
                        sh 'GIT_SSH_COMMAND="ssh -i $key"'
                        sh(
                                script: 'git clone "git@github.com:parkingology/parking-dev-env-variables.git"',
                                returnStdout: true
                        ).trim()
                    }

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
