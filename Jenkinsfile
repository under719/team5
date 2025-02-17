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
                // Git 저장소에서 소스 코드 체크아웃
                git branch: 'main', url: 'https://github.com/under719/team5.git'
            }
        }
        stage('Build with Gradle') {
            steps {
                script {
                    // Gradle 실행권한
                    sh 'chmod +x ./gradlew'
                    // Gradle 빌드 실행
                    sh './gradlew clean build'
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
                    // Docker 이미지를 Registry Server에 푸시
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes 배포 파일 적용 (app-deployment.yaml)
                    sh "kubectl apply -f ./yaml/app-deployment.yaml -n ${NAMESPACE}"
                }
            }
        }
        stage('Service to Create or Update') {
            steps {
                script {
                    // 서비스파일(app-service.yaml)을 적용하여 서비스를 생성하거나 업데이트
                    sh "kubectl apply -f ./yaml/app-service.yaml -n ${NAMESPACE}"
                }
            }
        }
        stage('Deployment Image to Update') {
            steps {
                script {
                    sh "kubectl set image deployment/springboot-app-team5-jhk springboot-app-team5-jhk=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
