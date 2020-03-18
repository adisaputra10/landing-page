pipeline {

    
    
    agent none
    triggers {
     pollSCM(env.BRANCH_NAME == 'master' ? '* * * * *' : env.BRANCH_NAME == 'release' ? '* * * * *' : '')
    }
    options {
        skipDefaultCheckout()
    }
    stages {
        stage ( "Kill old Build " ){
            steps{
                script{
                    sh "ls"
                }
            }
        }
        stage('Checkout SCM / Git pull') {
            agent { label "nodejs" }
            steps {
                checkout scm
                script {

                    env.DOCKER_REGISTRY = 'nurwahid'
                     env.DOCKER_IMAGE_NAME = 'landing_page'

                    echo "get COMMIT_ID"
                    sh 'echo -n $(git rev-parse --short HEAD) > ./commit-id'
                    commitId = readFile('./commit-id')
                }
                stash(name: 'ws', includes:'**,./commit-id')
            }
        }



 
             stage('Push Docker Image to Dockerhub') {
                 
                    steps {
                  script {
          sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
                  }}
    }
          stage('Deploy to Server') {
                 steps {
               script {
              sh 'sed -i "s/BUILD_NUMBER/$BUILD_NUMBER/g" landingpage.yaml'
              sh "kubectl apply -f landingpage.yaml"
              sh "kubectl --namespace=development get deployment"
         // sh "kubctl apply -f deployment"
               }}
    }
    stage('Remove Docker Image') {
           steps {
         script {
        sh "docker rmi $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"   }}
    }



  
       
    }
   
  


}


