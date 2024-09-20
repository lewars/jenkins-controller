pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', daysToKeepStr: '30'))
    }

    // set trigger to run every 5 minutes
    triggers {
        cron('H/5 * * * *')
    }

    stages {
        stage('Prepare') {
            steps {
                sh(script: 'task show-config',
                   label: 'Display current configuration')
            }
        }

        stage('Integration Test') {
            steps {
                sh(script: 'task integration-test', label: 'Run integration tests')
            }
            post {
                always {
                    sh(script: 'task stop-jenkins',
                       label: 'Stop Jenkins test instance')
                }
            }
        }

    post {
        success {
            echo "send a message to slack, placholder"
        }
        failure {
            echo "send a message to slack, placholder"
        }
    }
}
