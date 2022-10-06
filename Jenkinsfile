pipeline {
    agent any

    stages {
        stage('run services') {
            steps {
                sh 'docker-compose -f compose/main-infrastructure.yml up -d'
            }
        }
        stage('test if jeager is running') {
            steps {
                script {
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
