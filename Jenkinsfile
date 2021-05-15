pipeline {
    agent any

    stages {
		stage('Clean')
		 {
		  steps
		   {
			script
			 {
			  if (isUnix()) 
			   {
				sh 'mvn --batch-mode clean'
			   }
			  else
			   {
				bat 'mvn --batch-mode clean'
			   }
			 }
		   }
		 }
    	stage ('Build ') {

            steps {
			script
			 {
			  if (isUnix()) 
			   {
				sh 'mvnw clean compile'
			   }
			  else
			   {
                bat '.\\mvnw clean compile'
				}
            }
			}
        }
		stage ('Install ') {
            steps {
				script
				 {
				  if (isUnix()) 
				   {
					sh 'mvnw install'
				   }
				  else
				   {
						bat '.\\mvnw install'
					}
				}
			}
		}
        stage ('Testing ') {

            steps {
				script
				 {
				  if (isUnix()) 
				   {
					sh 'mvnw test'
				   }
				  else
				   {
						bat '.\\mvnw test'
					}
				}
			}
        
         
			post {
					always {
						junit '**/target/surefire-reports/TEST-*.xml'
				}
			}
		}
		
		stage('Sanity check')
		 {
		  steps
		   {
			script
			 {
			  if (isUnix()) 
			   {
				sh 'mvn --batch-mode checkstyle:checkstyle pmd:pmd pmd:cpd com.github.spotbugs:spotbugs-maven-plugin:spotbugs'
			   }
			  else
			   {
				bat '.\\mvnw --batch-mode checkstyle:checkstyle pmd:pmd pmd:cpd com.github.spotbugs:spotbugs-maven-plugin:spotbugs'
			   }
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
