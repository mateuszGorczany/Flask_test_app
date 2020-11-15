pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building image...'
        script {
          docker.build("${imageName}")
        }

      }
    }

    stage('Test') {
      agent {
        docker {
          image "${imageName}"
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
        docker {
          image "${imageName}"
          args '--publish 2115:1337'
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
        input(message: 'Publish created dockerimage on Dockerhub? y/n', submitterParameter: 'if_publish', ok: 'ok')
        script {
          docker.withRegistry('', "${registryCredential}")
          {
            imageToDeploy = docker.image("${imageName}")
            // imageToDeploy.push()
            echo 'Image pushed to your dockerhub repository'}
          }

        }
      }

      stage('Celeaning') {
        steps {
          sh 'docker image prune --all --force --filter "label!=python:3.8-slim"'
          sh 'Image removed'
        }
      }

    }
    environment {
      registry = 'mgorczany/docker-flask-test:'
      registryCredential = 'dockerhub'
      imageName = "${registry}${env.BUILD_ID}"
    }
  }