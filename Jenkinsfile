TEST_ENV = params.TEST_ENV ?: null

node("${NODE}") {
    def fluent
    try {
        stage('Clone repository') {
            checkout scm
        }
        stage('Build image') {
            fluent = docker.build("fluent/fluentd")
        }
        stage('Run container'){
            if (TEST_ENV == null) {
                throw NullPointerException("Param TEST_ENV must be specified.")
            }
            sh '''
                docker run -d --name fluentd -e TEST_ENV=${TEST_ENV} -v jmeter-logs:/jmeter-logs/ -v gatling-logs:/gatling-logs/ fluent/fluentd
             '''
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