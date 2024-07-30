pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                git 'https://github.com/shubham1910200/Node-todo-CI_CD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    dockerImage = docker.build("soma1999/todo-app-node:latest")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo 'Running Docker container...'
                    dockerImage.run("-d -p 8000:8000 --name todoapp-container")
                }
            }
        }

        stage('Verify Application') {
            steps {
                script {
                    echo 'Verifying application...'
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
                echo 'Cleaning up Docker container...'
                // Clean up Docker container
                sh 'docker rm -f todoapp-container || true'
            }
        }
    }
}
