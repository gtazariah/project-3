pipeline{
	agent any
	environment
	{
		DOCKERHUB_USERNAME='azariahgt'
	}	
	stages
	{
		stage('Checkout')
		{
			steps
			{
				checkout scm
			}
		}
		stage('Show Branch')
		{
			steps
			{
				echo "Building Branch: ${BRANCH_NAME}"
				echo "Build Number:${BUILD_NUMBER} "
			}
		}
		stage('Docker Login')
		{
			steps
			{
				withCredentials([usernamePassword(credentialsId:'dockerhub-credentials',usernameVariable: 'DOCKER_USER',passwordVariable: 'DOCKER_TOKEN')])
				{
					sh '''
						echo "$DOCKER_TOKEN" | \ 
						docker login \
						-u "$DOCKER_USER" \
						--password-stdin
					'''
				}
			}
		}

		stage('Build DEV')
		{
			when{
				branch 'dev'
			}
			steps
			{
				sh '''
					chmod +x build.sh
					./build.sh dev ${BUILD_NUMBER}
				'''
			}
		}

		stage('Build PROD')
		{
			when{
				branch 'master'
			}
			steps
			{
				sh '''
					chmod +x build.sh
					./build.sh prod ${BUILD_NUMBER}
				'''
			}
		}
	}

	post
	{
		success
		{
			echo "Pipeline Completed Successfully";
		}

		failure
		{
			echo "Pipeline failed"
		}

		always
		{
			sh 'docker logout || true'
		}
	}
}

