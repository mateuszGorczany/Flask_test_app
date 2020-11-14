pipeline {
  agent {
    docker {
      image 'python:3.8.6-alpine3.11'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'pip install -r requirements.txt'
      }
    }

    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

  }
}