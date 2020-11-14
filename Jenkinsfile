pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Test') {
      steps {
        sh 'python test.py'
      }
    }

    stage('Deliver') {
      steps {
        sh 'python app.py'
        input 'Finished using the web site? (Click "Proceed" to continue)'
        sh 'pkill -f app.py'
      }
    }

  }
}