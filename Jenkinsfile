pipeline {
    agent {
        kubernetes {
            label 'my-pod-template'
            defaultContainer 'jnlp'
            yaml """
spec:
  containers:
  - name: maven
    image: maven:alpine
    command:
    - cat
    tty: true
    volumeMounts:
      - name: maven-cache
        mountPath: /root/.m2/repository
  - name: busybox
    image: busybox
    command:
    - cat
    tty: true
  volumes:
    - name: maven-cache
      hostPath:
        path: /tmp
        type: Directory
"""
        }
    }
    stages {
        stage('Maven build') {
          steps {
              container('maven') {
                sh 'mvn -B clean package'
                archiveArtifacts 'target/*.jar'
              }
          }
        }
        stage('Maven verify'){
          steps {
            container('maven') {
              sh 'mvn -B -fail-never -DskipUnitTests=true verify'
            }
          }
        }
    }
}