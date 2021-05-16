pipeline {
    agent any
	environment { 
        registry = "niranjanpr/employee-service" 
        registryCredential = 'dockerhub_id' 
        dockerImage = '' 
    }
    stages {
		  
        stage ('Testing ') {
            steps {
				script{
				  if (isUnix()){
					sh 'mvnw test'
				   }
				  else{
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
		stage('Integration tests') {
		  steps{
			script{
			  if (isUnix()) {
				sh 'mvn --batch-mode failsafe:integration-test failsafe:verify'
			   }
			  else {
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
				  }
				}
            }
          }
		stage('Building image') {
		  steps{
			script {
				// def docker = "my docker"
			  dockerImage = docker.build registry +":$BUILD_NUMBER"
			}
		  }
		}
	   
		stage('Pushing to DockerHub') {
		 steps{  
			 script {
				 
					docker.withRegistry( '', registryCredential ) { 
					dockerImage.push() 
					}
				}
			}
		}
	  
		stage('Cleaning up') { 
			steps { 
				bat "docker rmi $registry:$BUILD_NUMBER" 
			}
		} 

	}
}
