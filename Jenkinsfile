pipeline {
    agent any

    stages {
    
    	 stage ('Compile Stage') {

            steps {
                bat '.\\mvnw clean compile'
            }
        }
        stage ('Testing Stage') {

            steps {
                    bat '.\\mvnw test'
            }
        }
        stage ('Install Stage') {
            steps {
                    bat '.\\mvnw install'
            }
         
		post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
		}
	}
}
