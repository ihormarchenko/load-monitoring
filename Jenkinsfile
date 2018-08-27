TEST_ENV = params.TEST_ENV ?: null
COMMAND = params.COMMAND ?: "PS"
node("${NODE}") {
    def fluent
    try {
        stage('Clone repository') {
            checkout scm
        }
        if(COMMAND == "PS"){
            info ()
        }
        if(COMMAND == "STOP"){
            stopContainer()
        }
        if(COMMAND == "RESTART"){
            restartContainer ()
        }
        if(COMMAND == "REMOVE"){
            removeContainer ()
        }
        if(COMMAND == "START"){
            startContainer ()
        }
        if(COMMAND == "BUILD"){
            buildImage ()
        }
        
        if(COMMAND == "SETUP"){
            buildImage ()
            runContainer ()
        }
        if(COMMAND == "RESETUP"){
            removeContainer ()
            buildImage ()
            runContainer ()
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        stage('Clear'){
            try{
                sh '''
                IDS=`docker images -f "dangling=true" -q`
                    if [[ $IDS != "" ]]; then docker rmi $IDS; fi
                '''
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
def info (){
    stage("PS"){
        sh '''
            docker ps -a
        '''
    }
}
def stopContainer (){
    stage("Stop container"){
        sh '''
            docker stop fluentd
        '''
    }
}
def startContainer (){
    stage("Start container"){
        sh '''
            docker start fluentd
        '''
    }
}
def restartContainer (){
    stage("Restart container"){
        sh '''
            docker restart fluentd
        '''
    }
}
def removeContainer (){
    stage("Remove container"){
        sh '''
            docker rm -f fluentd
        '''
    }
}
def runContainer (){
    stage('Run container'){
        if (TEST_ENV == null) {
            throw new NullPointerException("Param TEST_ENV must be specified.")
        }
        sh '''
            docker run -d --name fluentd -e TEST_ENV=${TEST_ENV} -v jmeter-logs:/jmeter-logs/ -v gatling-logs:/gatling-logs/ fluent/fluentd
         '''
    }
}
def buildImage (){
    stage('Build image') {
        fluent = docker.build("fluent/fluentd")
    }
}
