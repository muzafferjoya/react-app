pipeline {
  agent {
    docker {
     image 'node:14.16.0'
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
      git branch: 'develop',
      credentialsId: 'muzaffar-bitbucket',
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

stage('Deployment on S3 Bucket') {
  steps {
    withAWS(region:'ap-south-1',credentials:'kashif-aws-id') {
    s3Upload(bucket: 'mul-code/develop', workingDir:'build', includePathPattern:'**/*', excludePathPattern:'.git/*, **/node_modules/**');
            }
          }
        }
       
      }
      post {

         failure {
            emailext attachLog: true,
             body: '''${SCRIPT, template="groovy-html.template"}''', 
             subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed", 
             mimeType: 'text/html',from: "muzafferjoya@gmail.com", to: '$DEFAULT_RECIPIENTS'
          }
         success {
            emailext attachLog: true,
             body: '''${SCRIPT, template="groovy-html.template"}''', 
             subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful", 
             mimeType: 'text/html',from: "muzafferjoya@gmail.com", to: '$DEFAULT_RECIPIENTS'
          }     
    }
    }
