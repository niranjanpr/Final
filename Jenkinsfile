pipeline {
    agent any

    stages {
    
    	 stage ('Compile Stage') {

            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                    bat 'mvn clean compile'
                }
            }
        }
        stage ('Testing Stage') {

            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                    bat 'mvn test'
                }
            }
        }
        stage ('Install Stage') {
            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                    bat 'mvn install'
                }
            }
        }
        stage('Build') {
            steps {
                git 'https://github.com/niranjanpr/Final.git'
                //sh './mvnw clean compile'
                bat '.\mvnw clean compile'
            }
        }
        stage('Test') {
            steps {
                //sh './mvnw test'
                bat '.\mvnw test'
            }

            post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
    }
}