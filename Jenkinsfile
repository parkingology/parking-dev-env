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
                    git credentialsId: 'github-ssh', url: 'https://github.com/parkingology/parking-dev-env-variables.git'
                    sh "ls -lart ./*"
                    sh "git branch -a"

                    def httpStatus = sh (
                            script: 'curl -s -o /dev/null -w \"%{http_code}\\n\" http://host.docker.internal:16686',
                            returnStdout: true
                    ).trim()
                    assert httpStatus == '200'
                }
            }
        }
    }

}
