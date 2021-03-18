pipeline {
  agent {
    docker {
     image 'node:12.16.0'
     args '-p 8081:8081'
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
      git branch: 'master',
      credentialsId: 'bitbucket-login',
      url: 'git@bitbucket.org:muzaffarjoya/react-app-jenkins.git'
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
        stage('Create Build Artifacts') {
          steps {
            sh 'npm run build'
          }
        }
      }
    }

stage('Production') {
  steps {
    withAWS(region:'us-east-1',credentials:'muzaffar-aws-id') {
    s3Delete(bucket: 'muzaffar-khan/master', path:'**/*');
    s3Upload(bucket: 'muzaffar-khan/master', workingDir:'build', includePathPattern:'**/*', excludePathPattern:'.git/*, **/node_modules/**');
            }
          }
        }
       
      }
    }
    
