pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage("Pull SRC") {
            steps {
                git branch: 'main', url: 'https://github.com/bhoomikadk16/ansible-terraform.git'
            }
        }
        stage("Prepare Build") {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Copy the *.war file to ansible') {
            steps {
                sshPublisher(publishers: [
                    sshPublisherDesc(
                        configName: "ssh",
                        transfers: [
                            sshTransfer(
                                sourceFiles: '**/*.war',
                                removePrefix: 'target',
                                execCommand: """
                                """
                            )
                        ]
                    )
                ])
            }
        }
        stage('Copy the Docker file to ansible') {
            steps {
                sshPublisher(publishers: [
                    sshPublisherDesc(
                        configName: "ssh",
                        transfers: [
                            sshTransfer(
                                sourceFiles: 'Dockerfile',
                                removePrefix: '',
                                execCommand: """
                                    docker rm -f cont
                                    docker rmi ansi
                                    docker build -t ansi . 
                                    docker run -it -d --name cont -p 8081:8080 ansi
                                """
                            )
                        ]
                    )
                ])
            }
        }
        stage("Build Docker image and push to Dockerhub") {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: "ssh",
                            transfers: [
                                sshTransfer(sourceFiles: 'Dockerfile',
                                execCommand: """
                                docker rm -f cont
                                docker rmi -f bhoomika720/ansible
                                docker build -t bhoomika720/ansible .
                                docker login -u bhoomika720 -p dockeraccount
                                docker push bhoomika720/ansible
                                """)
                            ]
                        )
                    ]
                )
            }
            }
         stage("Copy playbook file to ansible and execute") {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: "ssh",
                            transfers: [
                                sshTransfer(sourceFiles: 'playbook.yml'
                                execCommand: "ansible-playbook playbook.yml")
                            ]
                        )
                    ]
                )
            
            }
        }
        
    }
}