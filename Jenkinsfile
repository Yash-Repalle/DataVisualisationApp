@Library("my-shared-lib") _

pipeline{

    agent any

    stages{

        stage("Git checkout"){

            steps{
                gitCheckout(
                    branch: "main",
                    url: "https://github.com/Yash-Repalle/DataVisualisationApp.git"
                )
            }
        }

        stage("Unit Test Maven"){

            steps{
                mvnTest()
            }
        }

        stage("Intigration Test Maven"){

            steps{
                mvnIntigrationTest()
            }
        }

        /*stage("Sonar Code Qality"){

            steps{
                withSonarQubeEnv('sonarqube') {
                sh 'mvn clean package sonar:sonar'
              }
            }
        }

        stage("Sonar Qality Gates"){

            steps{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube'
            }
        }*/

        stage("MVN Build"){

            steps{
                sh 'mvn clean install'
            }
        }

        stage("Docker Image Build"){

            steps{
                sh '''
                    docker image build -t yaswanth345/datavisual .
                    docker image tag yaswanth345/datavisual yaswanth345/datavisual:v1
                '''
            }
        }

        stage("Docker Image Scan : Trivy"){

            steps{
                sh '''
                    trivy image yaswanth345/datavisual:v1 > scan.txt
                    cat scan.txt
                '''
            }
        }

        stage("Docker Image Push"){

            steps{
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'pass', usernameVariable: 'username')]) {
                    sh "docker login -u '$username' -p '$pass'"
                }
                sh "docker image push yaswanth345/datavisual:v1"
            }
        }
    }    
}