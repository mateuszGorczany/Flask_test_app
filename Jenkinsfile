pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
      args '--publish 2115:1337 --name $registry:$BUILD_NUMBER'
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
        sh 'python app.py > flask.log 2>&1 &'
        sh 'cat flask.log'
        input 'Finished using the web site? (Click "Proceed" to continue)'
        sh 'pkill -f app.py'
      }
    }

    stage('Deploy') {
      steps {
        input 'Publish created dockerimage on Dockerhub? (Click "Proceed" to continue)'
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }

      }
    }

    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }

  }
  environment {
    registry = 'mgorczany/docker-flask-test'
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  post {
    always {
      junit 'test_reports/*.xml'
      archiveArtifacts 'flask.log'
      sh 'cat flask.log'
    }

  }
}