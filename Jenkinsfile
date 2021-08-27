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
  stage('Build') {
      steps {
        echo 'Building...!'

        echo 'Env vars for cloud pull request...'
        echo "BITBUCKET_SOURCE_BRANCH ${env.BITBUCKET_SOURCE_BRANCH}"
        echo "BITBUCKET_TARGET_BRANCH ${env.BITBUCKET_TARGET_BRANCH}"
        echo "BITBUCKET_PULL_REQUEST_LINK ${env.BITBUCKET_PULL_REQUEST_LINK}"
        echo "BITBUCKET_PULL_REQUEST_ID ${env.BITBUCKET_PULL_REQUEST_ID}"
        echo "BITBUCKET_PAYLOAD ${env.BITBUCKET_PAYLOAD}"

        echo 'Env vars for cloud push...'
        echo "REPOSITORY_LINK ${env.REPOSITORY_LINK}"
        echo "BITBUCKET_SOURCE_BRANCH ${env.BITBUCKET_SOURCE_BRANCH}"
        echo "BITBUCKET_REPOSITORY_URL ${env.BITBUCKET_REPOSITORY_URL}"
        echo "BITBUCKET_PUSH_REPOSITORY_UUID ${env.BITBUCKET_PUSH_REPOSITORY_UUID}"
        echo "BITBUCKET_PAYLOAD ${env.BITBUCKET_PAYLOAD}"

        echo 'Env vars for server push...'
        echo "REPOSITORY_LINK ${env.REPOSITORY_LINK}"
        echo "BITBUCKET_SOURCE_BRANCH ${env.BITBUCKET_SOURCE_BRANCH}"
        echo "BITBUCKET_REPOSITORY_URL ${env.BITBUCKET_REPOSITORY_URL}"
        echo "BITBUCKET_PUSH_REPOSITORY_UUID ${env.BITBUCKET_PUSH_REPOSITORY_UUID}"
        echo "BITBUCKET_PAYLOAD ${env.BITBUCKET_PAYLOAD}"
      }
    }
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
             subject: "Job Name # ${env.JOB_NAME} - Branch Name # ${env.BRANCH_NAME} - Build # ${env.BUILD_NUMBER} - Successful", 
             mimeType: 'text/html',from: "muzafferjoya@gmail.com", to: '$DEFAULT_RECIPIENTS'
          }     
    }
    }
