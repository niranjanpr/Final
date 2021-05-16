pipeline {
    agent any

    stages {
		
		stage("build & SonarQube analysis") {
            steps {
                bat '.\\mvn clean package sonar:sonar'
            }
          }
          stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
		  
		stage('Clean')
		 {
		  steps
		   {
			//git url:'https://github.com/niranjanpr/Final.git'
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
		 stage('SonarQubes analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    bat ".\\gradlew sonarqube"
                }
            }
        }
        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }

	}
}
