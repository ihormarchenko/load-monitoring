node(${NODE}) {
    
    stage("checkout scm"){
        checkout scm
    }
   
    stage ("Build and push image") {
        docker.withRegistry('https://docker.svc.ring.com', 'ARTIFACTORY_PIP_KEY') {

            def customImage = docker.build("docker.svc.ring.com/ring/load-testing-fluentd:${env.BUILD_ID}")

            /* Push the container to the custom Registry */
            customImage.push()
        }
    }
}