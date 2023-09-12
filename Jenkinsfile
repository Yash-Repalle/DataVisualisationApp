pipeline{

    agent any

    stages{

        stage("Git checkout"){

            steps{
                git(url: 'https://github.com/Yash-Repalle/DataVisualisationApp.git', branch: 'main')
            }
        }

        stage("Unit Test Maven"){

            steps{
                sh 'mvn test'
            }
        }

        stage("Intigration Test Maven"){

            steps{
                sh 'mvn verify -DskipUnitTests'
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
    }    
}