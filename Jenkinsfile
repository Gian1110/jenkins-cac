@Library('jenkins-libs') _
pipeline {
  agent any
 parameters {
    
    //server values
        string(name: 'remoteHost', defaultValue: '192.168.100.173', description: 'dns o ip del host')
        string(name: 'release_version', defaultValue: 'release/v1.0.0', description: 'version de la applicacion')
        
    }
    environment {
        // container values
        name_container = 'cac'
        puerto_imagen = '5001'
        path_proyect = './'
          
    }
    stages {

        stage('Checkout on release') {
            steps {
                script {

                    def releaseBranch = params.release_version
                    checkout([$class: 'GitSCM', 
                              branches: [[name: releaseBranch]], 
                              doGenerateSubmoduleConfigurations: false, 
                              extensions: [], 
                              userRemoteConfigs: [[
                                  url: scm.getUserRemoteConfigs()[0].getUrl()
                              ]]
                    ])
                    env.version_imagen = releaseBranch.split('v')[1]

                }
            }
        }

        stage('docker build and push') {
            steps {
                script{
                        def parameterMap = [:]
                        parameterMap["path"] = path_proyect
                        parameterMap["containerName"] = name_container
                        parameterMap["imagenVersion"] = version_imagen
                        dockerb.dockerBuildPush(parameterMap);
                }                                     
            }
        }
        stage('ssh pull') {
            steps {
                script{
                        def parameterMap = [:]
                        parameterMap["remoteHost"] = params.remoteHost
                        parameterMap["containerName"] = name_container
                        parameterMap["imagenVersion"] = version_imagen
                        dockerb.dockerPull(parameterMap);
                            
                    }
                    
                }  
            
        }

        stage('ssh rm and run') {
            steps {
                script{

                    def parameterMap = [:]
                    parameterMap["remoteHost"] = params.remoteHost
                    parameterMap["containerName"] = name_container
                    parameterMap["imagenVersion"] = version_imagen
                    parameterMap["containerPuert"] = puerto_imagen
                    dockerb.dockerRmRun(parameterMap);
                    
                    }
                }  
            
        }
    }

    }
