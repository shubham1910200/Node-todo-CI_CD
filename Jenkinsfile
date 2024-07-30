pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                git 'https://github.com/shubham1910200/Node-todo-CI_CD.git'
                echo 'Repository checkout complete.'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    dockerImage = docker.build("soma1999/todo_app-node:latest")
                    echo 'Docker image built successfully.'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo 'Running Docker container...'
                    dockerImage.run("-d -p 8000:8000 --name todoapp-container")
                    echo 'Docker container started.'
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
                    def status = sh(script: 'curl -f http://localhost:8000 || echo "Application is not running"', returnStatus: true)
                    if (status != 0) {
                        error("Application is not running")
                    } else {
                        echo 'Application is running.'
                    }
                }
            }
        }

        stage('Debug Connection') {
            steps {
                script {
                    echo 'Debugging connection from Jenkins...'
                    sh 'curl -f http://localhost:8000 || echo "Failed to connect from Jenkins"'
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
                echo 'Docker container cleaned up.'
            }
        }
    }
}
