pipeline {
    agent any
    environment {
        SONAR_HOME = tool "sonar"
    }
    stages {
        stage("Code clone") {
            steps {
                git url: "https://github.com/Nikhilkathale741/node-todo-cicd", branch: "master"
                echo "code clone done"
            }
        }
        stage("Code Build") {
            steps {
                sh 'docker build -t node-app:latest .'
                echo "Code Build DONE"
            }
        }
        stage("Sonarqube Analysis") {
            steps {
                withSonarQubeEnv("sonar") {
                    sh '$SONAR_HOME/bin/sonar-scanner -Dsonar.ProjectName=nikkusonar -Dsonar.ProjectKey=nikkusonar'
                }
            }
        }
        stage("Sonarqube QualityGates check") {
            steps {
                timeout(time: 1, unit: "MINUTES") {
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage("Trivy Scan") {
            steps {
                sh "Trivy Image Node-app"
            }
        }
        stage("Docker Push to DockerHUBrepo") {
            steps {
                withCredentials([usernamePassword(credentialsId: "DockerHubCreds", passwordVariable: "dockerpass", usernameVariable: "dockeruser")]) {
                    sh "docker login -u ${env.dockeruser} -p ${env.dockerpass}"
                    sh "docker tag node-app ${env.dockeruser}/node-app:latest"
                    sh "docker push ${env.dockeruser}/node-app:latest"
                }
            }
        }
        stage("DEPLOYMENT") {
            steps {
                sh 'docker-compose up -d'
                echo "APP IS DEPLOYED"
            }
        }
    }
}

