pipeline {
    agent any

    stages {
		  
		stage('Clean')
		 {
		  steps
		   {
			// git url:'https://github.com/niranjanpr/Final.git'
			script
			 {
			  if (isUnix()) 
			   {
				sh 'mvn --batch-mode clean'
			   }
			  else
			   {
				bat '.\\mvnw --batch-mode clean'
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
		// stage('Sanity check')
		 // {
		  // steps
		   // {
			// script
			 // {
			  // if (isUnix()) 
			   // {
				// sh 'mvn --batch-mode checkstyle:checkstyle pmd:pmd pmd:cpd com.github.spotbugs:spotbugs-maven-plugin:spotbugs'
			   // }
			  // else
			   // {
				// bat '.\\mvnw --batch-mode checkstyle:checkstyle pmd:pmd pmd:cpd com.github.spotbugs:spotbugs-maven-plugin:spotbugs'
			   // }
			 // }
		   // }
		 // }
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
		 
		 stage("build & SonarQube analysis") {
            steps {
				script{
				  withSonarQubeEnv('sonarserver') {
					bat '.\\mvnw clean package sonar:sonar'
					//'.\\mvnw sonar:sonar'
					// org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'//'
				  }
				}
            }
          }
		  
		  // stage("Quality Gate"){
          // timeout(time: 1, unit: 'HOURS') {
              // def qg = waitForQualityGate()
              // if (qg.status != 'OK') {
                  // error "Pipeline aborted due to quality gate failure: ${qg.status}"
              // }
          // }
      // }
		 // stage('SonarQubes analysis') {
            // steps {
                // withSonarQubeEnv('sonarserver') {
                    // bat ".\\gradlew sonarqube"
                // }
            // }
        // }
        // stage("Quality gate") {
            // steps {
                // waitForQualityGate abortPipeline: true
            // }
        // }

	}
}
