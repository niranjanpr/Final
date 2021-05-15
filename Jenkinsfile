pipeline {
    agent any

    stages {
    
    	 stage ('Compile Stage') {

            steps {
				//git 'https://github.com/niranjanpr/Final.git'
                bat '.\\mvnw clean compile'
            }
        }
		stage ('Install Stage') {
            steps {
                    bat '.\\mvnw install'
            }
		}
        stage ('Testing Stage') {

            steps {
                    bat '.\\mvnw test'
            }
        
        
         
		post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
		}
		  stage('Integration tests')
     {
      steps
       {
        script
         {
          if (isUnix()) 
           {
            sh 'mvn --batch-mode failsafe:integration-test failsafe:verify'
           }
          else
           {
            bat '.\\mvnw --batch-mode failsafe:integration-test failsafe:verify'
           }
         }
       }
     }
	}
}
