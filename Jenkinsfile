@Library("my-shared-lib") _

pipeline{

    parameters{

        choice(name: 'action', choices: 'create\ndestroy', description: 'choose create or delete')
    }

    agent any

    stages{

        stage("Git checkout"){
            when{ expression { params.action == 'create'}}
            steps{
                gitCheckout(
                    branch: "main",
                    url: "https://github.com/Yash-Repalle/DataVisualisationApp.git"
                )
            }
        }

        stage("Unit Test Maven"){
            when{ expression { params.action == 'create'}}
            steps{
                script{
                    mvnTest()
                }
            }
        }

        stage("Intigration Test Maven"){
            when{ expression { params.action == 'create'}}
            steps{
               script{
                    mvnIntigrationTest()
                }
            }
        }

        stage("Sonar Code Qality"){
            when{ expression { params.action == 'create'}}
            steps{
                script{
                    def SonarQubecredentialsId = 'sonarqube-token'
                    statiCodeAnalysis(SonarQubecredentialsId)
                }
            }
        }

        stage("Sonar Qality Gates"){

            steps{
                script{
                    def SonarQubecredentialsId = 'sonarqube-token'
                    qualityGateAnalysis(SonarQubecredentialsId)
                }
            }
        }

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