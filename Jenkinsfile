@Library('jenkins-libs') _
pipeline {
  agent any
 parameters {
    
    //server values
        string(name: 'remoteHost', defaultValue: '192.168.100.173', description: 'dns o ip del host')
        string(name: 'imagenVersion', defaultValue: '1.0.0', description: 'version de la applicacion')
        
    }
    environment {
        // container values
        name_container = 'cac'
        puerto_imagen = '5001'
        path_proyect = './'
          
    }
    stages {
        stage('existe version actual') {
            steps {
                script {
                    def parameterMap = [:]
                        parameterMap["remoteHost"] = params.remoteHost
                        parameterMap["containerName"] = name_container
                        parameterMap["imagenVersion"] = params.imagenVersion
                    env.equalsVersion = dockerb.dockerVersionContainer(parameterMap);
                }
            }
        }

        stage('Checkout on release') {
            when {
                expression {
                    return env.equalsVersion == "false";
                }
            }
            steps {
                script {
                    
                    def parameterMap = [:]
                    parameterMap["imagenVersion"] = params.imagenVersion
                    gitJob.checkoutBranch(parameterMap);

                }
            }
        }

        stage('docker build and push') {
            when {
                expression {
                    return env.equalsVersion == "false";
                }
            }
            steps {
                script{
                        def parameterMap = [:]
                        parameterMap["path"] = path_proyect
                        parameterMap["containerName"] = name_container
                        parameterMap["imagenVersion"] = params.imagenVersion
                        dockerb.dockerBuildPush(parameterMap);
                }                                     
            }
        }

        stage('ssh pull') {
            when {
                expression {
                    return env.equalsVersion == "false";
                }
            }
            steps {
                script{
                        def parameterMap = [:]
                        parameterMap["remoteHost"] = params.remoteHost
                        parameterMap["containerName"] = name_container
                        parameterMap["imagenVersion"] = params.imagenVersion
                        dockerb.dockerPull(parameterMap);
                            
                    }
                    
                }  
            
        }

        stage('ssh rm and run') {
            when {
                expression {
                    return env.equalsVersion == "false";
                }
            }
            steps {
                script{

                    def parameterMap = [:]
                    parameterMap["remoteHost"] = params.remoteHost
                    parameterMap["containerName"] = name_container
                    parameterMap["imagenVersion"] = params.imagenVersion
                    parameterMap["containerPuert"] = puerto_imagen
                    dockerb.dockerRmRun(parameterMap);
                    
                    }
                }  
            
        }
    }

    }
