Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { docker { image 'ruby' } }
    stages {
        stage('build') {
            steps {
                sh 'ruby --version'
                sh 'echo "Hello world!"'
                
                retry(2) {
                   sh './some-script.sh'
                }
                
                timeout(time: 3. unit: 'MINUTES') {
                   sh './health-check-script'
                }    
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            slackSend channel: '#ops-room',
            color: 'good',
            message: "The pipeline ${currentBuild.fullDisplayName} completed successfully.
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }  
    }    
}
