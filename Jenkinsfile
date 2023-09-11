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
    }    
}