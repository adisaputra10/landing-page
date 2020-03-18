env.DOCKER_REGISTRY = 'nurwahid'
env.DOCKER_IMAGE_NAME = 'landing_page'
node('master') {
    stage('Git Pull') {
          checkout scm
    }
      stage('Build Docker Image') {
        sh "docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER} ."   
        //echo env.BRANCH_NAME
        if( env.BRANCH_NAME == "development"){ echo "perintah ke server dev" }else{ echo "perintah ke server prod"}
    }
      stage('Push Docker Image to Dockerhub') {
          sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
    }
          stage('Deploy to Server') {
         // sh "kubctl apply -f deployment"
    }
    stage('Remove Docker Image') {
        sh "docker rmi $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"   
    }
}
