pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          dockerImage = docker.build("mgorczany/docker-flask-test:${BUILD_NUMBER}")
          Container = dockerImage.run("-it --publish 2115:1337")
        }

      }
    }

    stage('Test') {
      steps {
        script {
          Container.inside { sh 'python test.py' }
        }

      }
    }

    stage('Deliver') {
      steps {
        script {
          Container.inside {
            sh 'python app.py > flask.log 2>&1 &'
            sh 'cat flask.log'
            input 'Finished using the web site? (Click "Proceed" to continue)'
            sh 'pkill -f app.py'
          }
        }

      }
    }

    stage('Collect logs') {
      steps {
        script {
          Container.inside {
            junit 'test_reports/*.xml'
            archiveArtifacts 'flask.log'
            sh 'cat flask.log'
          }
        }

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
    dockerImage = ''
    Cointainer = ''
  }
}