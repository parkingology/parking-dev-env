pipeline {
    agent any

    stages {
        stage('run docker compose') {
            steps {
                echo 'hello world'
                sh 'docker-compose up -f compose/main-infrastructure.yml -d up'
            }
        }
    }

}
