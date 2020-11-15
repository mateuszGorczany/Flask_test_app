pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
      args '--publish 2115:1337'
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
        sh 'docker tag $(docker image ls -q | head -1) ${registry}:${env.BUILD_ID}'
      }
    }

    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $dockerImage"
      }
    }

  }
  environment {
    registry = 'mgorczany/docker-flask-test:'
    registryCredential = 'dockerhub'
    dockerImage = "${registry}:${env.BUILD_NUMBER}"
  }
  post {
    always {
      junit 'test_reports/*.xml'
      archiveArtifacts 'flask.log'
      sh 'cat flask.log'
    }

  }
}