def envRepoName = 'parking-dev-env-variables'
def prodVariables

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
                        def githubRepo = "git@github.com:parkingology/${envRepoName}.git"
                        sh "rm -rf ${envRepoName}"
                        sh 'GIT_SSH_COMMAND="ssh -i $key"'
                        sh(
                                script: 'eval "$(ssh-agent)" && ssh-add $key && git clone ' + githubRepo,
                                returnStdout: true
                        ).trim()
                    }
                }
            }
        }

        stage('setup env addresses') {
            steps {
                script {
                    echo 'env file: ' + "${envRepoName}/env/prod.yml"
                    prodVariables = readYaml (file: "./${envRepoName}/env/prod.yml")
                }
            }
        }


        stage('test services') {
            steps {
                script {
                    testServiceWithCurl("${prodVariables.services.jaeger.url}", '200')
                    testServiceWithCurl("${prodVariables.services.kibana.url}", '302')
                    testServiceWithCurl("${prodVariables.services.rabbitmq.url}", '200')
                }
            }
        }
    }
}

def testServiceWithCurl(url, expectedHttpStatus){
    echo "test ${url} host"

    def httpStatus = sh(
            script: "curl -s -o /dev/null -w \"%{http_code}\\n\" ${url}",
            returnStdout: true
    ).trim()

    echo "responseStatus: ${httpStatus}"
    assert httpStatus == expectedHttpStatus
}
