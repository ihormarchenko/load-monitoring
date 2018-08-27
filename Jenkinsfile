TEST_ENV = params.TEST_ENV ?: null
COMMAND = params.COMMAND ?: "PS"
node("${NODE}") {
    def fluent
    try {
        stage('Clone repository') {
            checkout scm
        }
        if(COMMAND == "PS"){
            stage("Stop container"){
                sh '''
                    docker ps -a
                '''
            }
        }
        if(COMMAND == "STOP"){
            stage("Stop container"){
                sh '''
                    docker stop fluentd
                '''
            }
        }
        if(COMMAND == "RESTART"){
            stage("Stop container"){
                sh '''
                    docker restart fluentd
                '''
            }
        }
        if(COMMAND == "REMOVE"){
            stage("Stop container"){
                sh '''
                    docker rm -f fluentd
                '''
            }
        }
        if(COMMAND == "START"){
            stage('Run container'){
                if (TEST_ENV == null) {
                    throw new NullPointerException("Param TEST_ENV must be specified.")
                }
                sh '''
                    docker run -d --name fluentd -e TEST_ENV=${TEST_ENV} -v jmeter-logs:/jmeter-logs/ -v gatling-logs:/gatling-logs/ fluent/fluentd
                 '''
            }
        }
        if(COMMAND == "BUILD"){
            stage('Build image') {
                fluent = docker.build("fluent/fluentd")
            }
        }
        
        if(COMMAND == "SETUP"){
            stage('Build image') {
                fluent = docker.build("fluent/fluentd")
            }
            stage('Run container'){
                if (TEST_ENV == null) {
                    throw new NullPointerException("Param TEST_ENV must be specified.")
                }
                sh '''
                    docker run -d --name fluentd -e TEST_ENV=${TEST_ENV} -v jmeter-logs:/jmeter-logs/ -v gatling-logs:/gatling-logs/ fluent/fluentd
                 '''
            }
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