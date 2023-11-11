pipeline {
    agent any {label "Docker-node"}

    environment {
        AWS_CREDENTIALS = credentials('your-aws-credential-id')
    }

    stages {
        stage('SCM Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/ECR-Testing']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/Farooq-cloud/Terraform-Practice.git']])
            }
        }

        stage('Build and Push to ECR') {
            steps {
                script {
                    // Use AWS credentials from environment variables
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'ECR-CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // Authenticate Docker with ECR using AWS credentials
                        sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 097348731047.dkr.ecr.ap-south-1.amazonaws.com"

                        // Build Docker image
                        sh "docker build -t farooq:latest ."

                        // Tag the Docker image for ECR
                        sh "docker tag farooq:latest 097348731047.dkr.ecr.ap-south-1.amazonaws.com/farooq:latest"

                        // Push the Docker image to ECR
                        sh "docker push 097348731047.dkr.ecr.ap-south-1.amazonaws.com/farooq:latest"
                    }
                }
            }
        }
    }
}
