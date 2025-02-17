pipeline {
    agent any
    environment {
        REGISTRY = "k8s-vga-worker1:5000"
        IMAGE_NAME = "team5-demo-app-jhk"
        IMAGE_TAG = "latest"
        NAMESPACE = "under76-test"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/under719/team5.git'
            }
        }
        stage('Build with Gradle') {
            steps {
                script {
                    sh './gradlew clean build -x test'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl set image deployment/springboot-app-team5-jhk springboot-app-team5-jhk=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
