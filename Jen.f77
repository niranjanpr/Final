pipeline {
    agent any
	 environment {
        registry = "326213389784.dkr.ecr.us-east-1.amazonaws.com/docker"
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
		stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 326213389784.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker push 326213389784.dkr.ecr.us-east-1.amazonaws.com/docker:latest'
         }
        }
      }
   
	}
}
