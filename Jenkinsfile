pipeline {
  agent {
    docker {
     image 'node:14.16.0'
<<<<<<< HEAD
     args '-p 8081:8081'
=======
     args '-p 3000:3000'
>>>>>>> f832f1deb0dfebf1f68cb5af80b3155c4a5e1cb0
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
<<<<<<< HEAD
      git branch: 'master',
=======
      git branch: 'staging',
>>>>>>> f832f1deb0dfebf1f68cb5af80b3155c4a5e1cb0
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
<<<<<<< HEAD
        stage('Create Build Artifacts') {
          steps {
            sh 'npm run build'
          }
        }
      }
    }

stage('Production') {
  steps {
    withAWS(region:'us-east-1',credentials:'aws-id') {
    s3Upload(bucket: 'muzaffar-khan', workingDir:'build', includePathPattern:'**/*', excludePathPattern:'.git/*, **/node_modules/**');
            }
          }
        }
=======
       
      }
    }

>>>>>>> f832f1deb0dfebf1f68cb5af80b3155c4a5e1cb0
    }
}
