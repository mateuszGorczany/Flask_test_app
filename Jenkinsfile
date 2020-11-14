pipeline {
  agent {
    docker {
      image 'python:3.8.6-alpine3.11'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'packages.sh && python app.py'
      }
    }

    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

  }
}