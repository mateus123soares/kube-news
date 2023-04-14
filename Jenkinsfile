pipeline {
    agent any

    stages {
        stage("Build docker Image") {
            steps {
                script {
                    dockerapp = docker.build("mts988/kube-news:${env.BUILD_ID}", '-f . .')
                }
            }
        }
        stage("Push docker Image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }

        stage("Deploy Kubernetes"){
            environment {
                tag_version = '${env.BUILD_ID}'
            }
            steps {
                withKubeConfig([credentialsId]: 'kubeconfig'){
                    sh 'sed -i "s/{{TAG}}/$tag_version/g" ./kubernetes/deployment.yml'
                    sh 'kubectl apply -f kubernetes'
                }
            }
        }
    }
}