pipeline {
    agent any

    stages {
        stage('run docker compose') {
            steps {
                echo 'hello world'
                sh 'cd compose/'
                sh 'docker compose -f main-infrastructure.yml up -d'
            }
        }
    }

}
