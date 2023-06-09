pipeline {
    agent any
    tools {
        maven 'maven_3_9_2'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '**']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Cnupur29/docker-demo']])
                sh 'mvn clean install'
            }
        }
        stage('Build Docker image'){
            steps{
                script{
                    sh 'mvn spring-boot:build-image'
                }
            }
        }
        stage('Push image to docker hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u schaudha2903 -p ${dockerhubpwd}'
                    sh 'docker tag docker-demo:0.0.1-SNAPSHOT schaudha2903/docker-demo'
                    sh 'docker push schaudha2903/docker-demo'
                    }
                }
            }
        }
        stage('Kubernetes integration'){
            steps{
                sh 'kubectl create deployment demo --image=schaudha2903/docker-demo --dry-run=client -o=yaml > deployment.yaml'
                sh 'echo --- >> deployment.yaml'
                sh 'kubectl create service clusterip demo --tcp=8081:8081 --dry-run=client -o=yaml >> deployment.yaml'
                sh 'kubectl get all'
                sh 'kubectl apply -f deployment.yaml'
            }
        }
        stage('Pausing') {
            steps {
                sleep(time: 2, unit: 'MINUTES')
            }
        }
        stage('Run the API'){
            steps{
                sh 'kubectl port-forward svc/demo 8081:8081'
            }
        }
    }
}