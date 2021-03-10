pipeline {
  agent {
    docker {
     image 'node:14.16.0'
     args '-p 3000:3000'
    }
  }
  environment {
    CI = 'true'
    HOME = '.'
    npm_config_cache = 'npm-cache'
  }
  stages {
    stage('Checkout External Project'){
      steps{
      git branch: 'staging',
      credentialsId: 'bitbucket-login',
      url: 'git@bitbucket.org:muzaffarjoya/react-app-jenkins.git'
      sh "ls -lat"
    }
  }
    stage('Install Packages') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test and Build') {
      parallel {
        stage('Run Tests') {
          steps {
            sh 'npm run test'
          }
        }
       
      }
    }

    }
}
