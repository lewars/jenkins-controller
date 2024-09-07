pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh title: 'Build Task', script: 'task build'
            }
        }
        stage('Unit Test') {
            steps {
                echo 'Testing..'
                sh title: 'Unit Test Task', script: 'task test-unit'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
