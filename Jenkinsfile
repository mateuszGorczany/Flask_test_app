pipeline {
  agent {
    docker {
      image 'python:3.8.6-alpine3.11'
    }

  }
  stages {
    stage('Build') {
      steps {
        withEnv(overrides: ["HOME=${env.WORKSPACE}"]) {
          sh 'pip install -r requirements.txt & python app.py'
        }

      }
    }

    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

  }
}