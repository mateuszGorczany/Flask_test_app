pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
      args '--publish 2115:1337'
    }

  }
  stages {
    stage('Test') {
      post {
        always {
          junit 'test-reports/*.xml'
        }

      }
      steps {
        sh 'python test.py'
      }
    }

    stage('Deliver') {
      steps {
        sh 'python app.py > .logs 2>&1 &'
        input 'Finished using the web site? (Click "Proceed" to continue)'
        sh 'pkill -f app.py'
        sh 'cat .logs'
      }
    }

  }
}