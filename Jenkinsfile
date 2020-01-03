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
        stage('Run maven') {
            steps {
                container('maven') {
                    sh 'mvn -B clean package'
                }
            }
        }
    }
}