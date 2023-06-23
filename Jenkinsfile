// Get Artifactory server instance, defined in the Artifactory Plugin administration page.
def server = Artifactory.server "MOPS Artifactory"
// Create an Artifactory Maven instance.
//def rtMaven = Artifactory.newMavenBuild()
def buildInfo
pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    stages {
        stage ('Maven Build From Java 11 container') {
            agent {
                docker {
                    image 'maven:3.6.0-jdk-11-slim'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn clean test'
            }
        }
    }
}
