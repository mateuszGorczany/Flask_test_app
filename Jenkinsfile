pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        dockerfile {
          filename 'Dockerfile'
          additionalBuildArgs "--tag ${registry}${env.BUILD_ID}"
          reuseNode true
        }

      }
      steps {
        sh 'echo Building image...'
      }
    }

    stage('Test') {
      agent {
        docker {
          image "${registry}${env.BUILD_ID}"
          args '--publish 2115:1337'
        }

      }
      post {
        always {
          junit 'test_reports/*.xml'
        }

      }
      steps {
        sh 'python test.py'
      }
    }

    stage('Deliver') {
      agent {
        dockerfile {
          label "${registry}:${env.BUILD_ID}"
        }

      }
      post {
        always {
          archiveArtifacts 'flask.log'
          sh 'cat flask.log'
        }

      }
      steps {
        sh 'python app.py > flask.log 2>&1 &'
        sh 'cat flask.log'
        input 'Finished using the web site? (Click "Proceed" to continue)'
        sh 'pkill -f app.py'
      }
    }

    stage('Deploy') {
      agent any
      steps {
        input 'Publish created dockerimage on Dockerhub? (Click "Proceed" to continue)'
        sh 'docker tag $(docker image ls -q | head -1) ${registry}:${env.BUILD_ID}'
      }
    }

    stage('Remove Unused docker image') {
      agent any
      steps {
        sh "docker rmi $dockerImage"
      }
    }

  }
  environment {
    registry = 'mgorczany/docker-flask-test:'
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
}