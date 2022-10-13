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
                    checkout scm  // successfully accesses github credentials
                    withCredentials([sshUserPrivateKey(credentialsId: 'github-ssh')]) {
                        echo sh(
                                script: '''GIT_SSH_COMMAND='ssh -i ${keyfile} 'git ls-remote --heads \"https://github.com/parkingology/parking-dev-env-variables.git\" master''',
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
