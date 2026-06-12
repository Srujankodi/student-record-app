pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '/usr/local/bin/docker compose build'
            }
        }

        stage('Run Containers') {
            steps {
                sh '/usr/local/bin/docker compose down || true'
                sh '/usr/local/bin/docker compose up -d'
            }
        }

        stage('Check Containers') {
            steps {
                sh '/usr/local/bin/docker ps'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}