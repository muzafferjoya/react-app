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
  stages{
      stage('Checkout'){
          steps{
              checkout scm
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
            echo "skip test"
          }
        }
        stage('Create Build Artifacts') {
          steps {
            sh 'npm run build'
          }
        }
      }
    }
    stage('Deployment') {
      parallel {
        stage('Deployment on Development') {
          when {
            branch 'develop'
          }
          steps {
            withAWS(region:'ap-south-1',credentials:'muzaffar-aws-id') {
              s3Delete(bucket: 'website-develop', path:'**/*')
              s3Upload(bucket: 'website-develop', workingDir:'build', includePathPattern:'**/*', excludePathPattern:'.git/*, **/node_modules/**');
            }
            
          }
        }
        stage('Deployment on Staging') {
          when {
            branch 'staging'
          }
          steps {
             withAWS(region:'ap-south-1',credentials:'muzaffar-aws-id') {
              s3Delete(bucket: 'website-staging-develop', path:'**/*')
              s3Upload(bucket: 'website-staging-develop', workingDir:'build', includePathPattern:'**/*', excludePathPattern:'.git/*, **/node_modules/**');
            }
            
          }
        }
      }
    }
  }
  
    
}
