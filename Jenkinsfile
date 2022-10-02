pipeline {
    agent any

    stages {
        stage('run docker compose') {
            steps {
                echo 'hello world'
                sh 'cd compose/ \ docker compose up -f main-infrastructure.yml -d up'
            }
        }
    }

}
