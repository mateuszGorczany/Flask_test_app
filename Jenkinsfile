pipeline {
  agent {
    docker {
      image 'python:3.8.6-alpine3.11'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'export WORKSPACE=`pwd` && pip install -r requirements.txt --user & python app.py'
      }
    }

    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

  }
}