pipeline {
    agent any
    triggers {
        pollSCM(env.BRANCH_NAME == 'master' ? '* * * * *' : env.BRANCH_NAME == 'release' ? '* * * * *' : '')
    }
    stages {
        stage('Checout SCM') {
            steps {
                checkout scm
                sh "ls"
                     script {

                    env.DOCKER_REGISTRY = 'nurwahid'
                     env.DOCKER_IMAGE_NAME = 'landing_page'
                         
                     }
            }
        }
        
        
        stage('Build Docker') {
            steps {
                
                sh "docker build . -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
            }
        }
        
        
            stage('Push Docker Image to Dockerhub') {
            steps {
                sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
            }
        }
        
            stage('Deploy To server') {
            steps {
              
                sh 'sed -i "s/BUILD_NUMBER/$BUILD_NUMBER/g" landingpage.yaml'
              //sh "kubectl apply -f landingpage.yaml"
              //sh "kubectl --namespace=development get deployment"
                
                   timeout(10) {
            input message: 'Deploy to PRODUCTION?', ok: 'Deploy'
        }
              
            }
        }
        
        
        
        
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
    }
}
