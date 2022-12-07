pipeline{
    agent any
    tools{
        maven 'maven-3.8.5'
    }
    environment{
        registry = '201882285541.dkr.ecr.us-east-2.amazonaws.com/java'
        registryCredential = 'jenkins-ecr-login-credentials'
        dockerimage = ''
    }
    stages{
        
        stage('Build the package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage("Sonar Quality Check"){
            steps{
                script{
                    withSonarQubeEnv(installationName:'sonar-9', CredentialsID: 'sonar-jenkins-auth'){
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage("Quality gate") {
                steps {
                    script {    
                      def qualitygate = waitForQualityGate()
                      sleep(10)
                      if (qualitygate.status != "OK") {
                          
                        waitForQualityGate abortPipeline: true
                            }
                         }
          }
        }
        stage('Build the Image'){
            steps {
                script {
                    dockerImage = docker.build registry + ":V$BUILD_NUMBER"
                }
            }
        }
        stage ('Deploy the Image to Amazon ECR') {
               steps {
                   script {
                   docker.withRegistry("http://" + registry, "ecr:us-east-2:" + registryCredential) {
                   dockerImage.push()
                            }
                     }
                 }
        }
        
    }
}
