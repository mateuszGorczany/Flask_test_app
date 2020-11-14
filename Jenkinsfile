pipeline {
  agent {
    docker {
      image 'python:3.8.6-alpine3.11'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh '''pip install virtualenv \\virtualenv venv --distribute
\\. venv/bin/activate 
\\pip install -r requirements.txt'''
      }
    }

    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

  }
}