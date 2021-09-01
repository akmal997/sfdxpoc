#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
    def TEST_LEVEL= 'RunLocalTests'

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = tool 'toolbelt'
    println toolbelt

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
        properties([pipelineTriggers([githubPush()])])
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {

        stage('Build Stage'){
             if (isUnix()) {
                rc = sh returnStatus: true, script: "${toolbelt} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST} -s -a DevHub"
            }else{
		    //bat "${toolbelt} plugins:install salesforcedx@49.5.0"
		   // bat "${toolbelt} update"
		    //bat "${toolbelt} auth:logout -u ${HUB_ORG} -p" 
                 rc = bat returnStatus: true, script: "${toolbelt} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --loglevel DEBUG --setdefaultdevhubusername --instanceurl ${SFDC_HOST} -s -a DevHub"
            }
		
            if (rc != 0) { 
		    println 'inside rc 0'
		    error 'hub org authorization failed' 
            }else{
			println 'rc not 0'
		    }

			println rc

            if(isUnix()){
                 bs = sh returnStatus: true, script: "${toolbelt} force:source:convert -p /var/lib/jenkins/workspace/sfdxpocpipeline_master/force-app -d manifest/"
            }else{
                bs = bat returnStatus: true, script: "${toolbelt} force:source:convert -p C:/Users/tfadmin/.jenkins/workspace/ines_Salesforcepocproject_master/force-app -d manifest/"
            }

            if (rc != 0) { 
		    println 'inside bs 0'
		    error 'build failed' 
            }else{
			println 'bs not 0'
		    }

			println rc
			
        }
        
        stage("UI Testing"){
                if(isUnix()){
                    // createScratchOrg = sh returnStatus: true, script: "${toolbelt} force:org:create -v DevHub --setdefaultusername --definitionfile /var/lib/jenkins/workspace/sfdxpocpipeline_master/config/project-scratch-def.json --setalias testScratchOrg --wait 10 --durationdays 1"
                    //     if (createScratchOrg != 0) {
                    //     error 'Salesforce test scratch org creation failed.'
                    //     }
                    list = sh returnStatus: true, script: "${toolbelt} force:org:list"
                    status = sh returnStatus: true, script: "${toolbelt} force:source:status -u testScratchOrg"
                    // pushScourceCode = sh returnStatus: true, script: "${toolbelt} force:source:push -u testScratchOrg"
                    //     if (pushScourceCode != 0) {
                    //     println pushScourceCode
                    //     error 'Salesforce push to test scratch org failed.'
                    //     }
                    testResult = sh returnStatus: true, script: "${toolbelt} force:apex:test:run --targetusername testScratchOrg --wait 10 --resultformat tap --codecoverage --testlevel ${TEST_LEVEL}"
                        if (testResult != 0) {
                        sh script: "${toolbelt} force:apex:test:run --targetusername testScratchOrg --wait 10 --resultformat tap --codecoverage --testlevel ${TEST_LEVEL}"  
                        error 'Salesforce unit test run in test scratch org failed.'
                        }
                }
             
                    deleteOrg =  command "${toolbelt} force:org:delete -u testScratchOrg "
                        if(deleteOrg){
                            error "Salesforce test scratch org deleting failed"
                        }
        }

        stage('Deploy Code') {
			// need to pull out assigned username
			if (isUnix()) {
				//rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
				rmsg = sh returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -u ${HUB_ORG}"
			}else{
				rmsg = bat returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -u ${HUB_ORG}"
			   //rmsg = bat returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
			}
			  
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
        }
    }
}

