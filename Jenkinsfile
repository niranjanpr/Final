pipeline {
    agent any

    stages {
    
		stage("test") {
               gitlabCommitStatus("test") {
                   sh "mvn verify -DgitRevision=$revision"
               }
           }
    	 stage ('Compile Stage') {

            steps {
                withMaven(maven : 'apache-maven-3.6.1') {
                bat '.\mvn clean compile'
				
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
                    bat 'mvnw install'
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
