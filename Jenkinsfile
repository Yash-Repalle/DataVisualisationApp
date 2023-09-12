@Library("my-shared-lib") _

pipeline{

    parameters{

        choice(name: 'action', choices: 'create\ndestroy', description: 'choose create or delete')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'datavisual')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'yaswanth345')
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
                script{
                    mvnBuild()
                }
            }
        }

        stage("Docker Image Build"){

            steps{
                buildDockerImage("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
            }
        }

        stage("Docker Image Scan : Trivy"){

            steps{
                imageScanTrivy("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
            }
        }

        stage("Docker Image Push"){

            steps{
                dockerImagePush("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
            }
        }
    }    
}