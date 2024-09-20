pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', daysToKeepStr: '30'))
        timestamps()
        ansiColor('xterm')
        skipStagesAfterUnstable()
    }

    stages {
        stage('Prepare') {
            steps {
                sh(script: 'task show-config',
                   label: 'Display current configuration')
            }
        }

        stage('Build') {
            steps {
                sh(script: 'task build', label: 'Build Docker image')
            }
        }

        stage('Unit Test') {
            steps {
                sh(script: 'task unit-test', label: 'Run unit tests')
            }
            post {
                always {
                    sh(script: 'task stop-jenkins',
                       label: 'Stop Jenkins test instance')
                }
            }
        }

        stage('Push Image') {
            when {
                expression {
                    return false
                }
                // branch 'main'
            }
            steps {
                sh(script: 'task push',
                   label: 'Push Docker image to repository')
            }
        }

        stage('Release') {
            when {
                expression {
                    return false
                }
                // branch 'main'
            }
            steps {
                sh(script: 'task release', label: 'Create GitHub release')
            }
        }
    }

    post {
        always {
            sh(script: 'task clean', label: 'Clean up environment')
            sh(script: 'task stop-jenkins', label: 'Stop Jenkins test instance')
        }
        failure {
            echo "send a message to slack, placholder"
        }
    }
}
