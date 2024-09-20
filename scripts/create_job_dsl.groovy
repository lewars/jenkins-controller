pipelineJob('jenkins-ci-test') {
    description('Updated Pipeline for building, testing, and deploying using Taskfile')

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('file:///jenkins-controller')
                    }
                    branch('*/main')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }

    properties {
        disableConcurrentBuilds()
        buildDiscarder {
            strategy {
                logRotator {
                    numToKeepStr('10')
                    daysToKeepStr('30')
                }
            }
        }
    }

    triggers {
        scm('H/15 * * * *')
    }

    wrappers {
        timeout {
            absolute(10)
        }
        timestamps()
        ansiColor('xterm')
    }

    publishers {
        extendedEmail {
            recipientList('$DEFAULT_RECIPIENTS')
            defaultSubject('$DEFAULT_SUBJECT')
            defaultContent('$DEFAULT_CONTENT')
            contentType('text/html')
            triggers {
                failure {
                    sendTo {
                        recipientList()
                    }
                }
            }
        }
    }
}
