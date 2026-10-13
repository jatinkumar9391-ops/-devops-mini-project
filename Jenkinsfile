pipeline {
  agent any
  environment {
    KUBECONFIG = '/var/lib/jenkins/.kube/config'
  }
  stages {
    stage('Checkout') {
      steps { 
        git branch: 'main', url: 'https://github.com/jatinkumar9391-ops/-devops-mini-project.git' 
      }
    }
    stage('Docker Build') {
      steps { 
        sh 'docker build -t todo-app:latest ./app' 
        sh 'docker save todo-app:latest | sudo k3s ctr images import -'
      }
    }
    stage('K8s Deploy') {
      steps { 
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }
}
