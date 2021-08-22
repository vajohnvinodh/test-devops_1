pipeline {
  agent any
  stages {
    stage('Git checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CheckoutOption']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url: 'https://github.com/vajohnvinodh/test-devops.git']]])
      }
    }
    stage('Building the image') {
      steps {
        sh """
        docker build -t "vajohnvinodh/nodejsapplication" .
        """
      }
    }
    stage('Image Push to Dockerhub') {
    steps {
		script {
		withDockerRegistry(credentialsId: 'dockerhub_john') {
		sh """
		docker push "vajohnvinodh/nodejsapplication"
		"""
	}
	}
	}
	}    

    }
  }
