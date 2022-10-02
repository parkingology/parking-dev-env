pipeline {
    agent any

    stages {
        stage('run docker compose') {
            steps {
                echo 'hello world'
                sh 'docker compose -f compose/main-infrastructure.yml up -d'
            }
        }
    }

}
