pipeline {
    agent any

    stages {
    
		
    	 stage ('Compile Stage') {

            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                bat '.\\mvnw clean compile'
                }
            }
        }
        stage ('Testing Stage') {

            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                    bat '.\\mvnw test'
                }
            }
        }
        stage ('Install Stage') {
            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                    bat '.\\mvnw install'
                }
            }
        }   
        } 
		post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
 }
