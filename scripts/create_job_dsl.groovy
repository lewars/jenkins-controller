pipelineJob('jenkins-ci-test') {
    description('Jenkins pipeline for building, testing, and deploying Jenkins using Task')

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
}
