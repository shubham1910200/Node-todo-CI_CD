pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/shubham1910200/Node-todo-CI_CD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker Image ...'
                    dockerImage = docker.build("soma1999/todo-app-node:latest")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run("-d -p 8000:8000 --name todoapp-container")
                }
            }
        }

        stage('Verify Application') {
            steps {
                script {
                    // Wait for the application to start
                    sleep(10)

                    // Verify the application is running
                    sh 'curl -f http://localhost:8000 || exit 1'
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up Docker container
                sh 'docker rm -f todoapp-container || true'
            }
        }
    }
}
