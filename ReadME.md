# Capstone Project

In this project below are the Technologies and Tools involved:
- Linux
- Bash Scripting
- GitHub Repository
- Jenkins
- Docker Runtime
- Docker-Compose
- Terraform
- Prometheus &
- AlertManager

## Step: 1

- Cloned the Reactjs application to local and made a own repo from it.
- Created two repo in Docker Hub. One is capstone-prod (Private) and another one capstone-dev (Public).
- Written a terraform code to deploy an EC2 machine in AWS to use that as my Jenkins Server.
- Along with the Terraform code, copied couple of installation scripts (Jenkins.sh and Install.sh).
  - Jenkins.sh contains bash script to install Java and Jenkins.
  - Install.sh contains bash script to install other required tools like Docker, Docker-Compose, AWS CLI and Terraform.
- Also it contains prometheus.sh script to start the container for Prometheus and AlertManager using the prometheus-docker-compose.yaml and Prometheus & AlertManager configuration files (prometheus.yml, alertmanager.yml and alert_rules.yml).

## Step: 2

- Written an another Terraform code to provision an EC2 Instance to host the application. This Terraform code will run from Jenkins and added the steps for it in Jenkinsfile.
  - In the Terraform directory, We have included docker-compose.sh, docker-compose.yaml, Install.sh, node_exporter.service and node_exporter.sh.
  - Uploaded these files in to Project Repo along side of the application.

## Step: 3

- Once the EC2 Instance for Jenkins provisioned, configured the Jenkins by installing required plugins, adding credentials, setting up environment variable, configuring AWS CLI and authenticating to Docker Hub repo.
- Then created a Pipeline Job specifying the Project Repo and it's branches (main and dev).
- Added the Jenkins URL to GitHub Webhook to trigger the build automatically when it recognize any changes in the repo.
- Used Jenkinsfile for the pipeline to run.
  - In the Jenkinsfile, added the environment variable of the DOCKER_ID.
  - Syntax to login to Docker Hub.
  - And provided execute access to build.sh and build_and_push.sh.
    - build.sh is referred inside the build_and_push.sh to build the application.
    - build_and_push.sh will recognize which branch has got updated and according to that it will build the specific branch code and push it to Docker Hub repo accordingly.
  - After the Push is successful, The Jenkins will proceed to provision an EC2 Instance using the Terraform code from Step 2.

## Step: 4

- Once the EC2 Instance is provisioned to host the application. As per the Terraform code, it will copy the scripts and configuration files on to the remote machine and execute as intended.
  - Install.sh is to install necessary tools like Docker and Docker-Compose.
  - node_exporter.sh is to download node exporter and move it to appropriate location and start the node_exporter.service.
  - docker-compose.sh to check if a container is running with the same name and if so, it will bring it down and run the docker-compose.yaml file to spin a new container with the latest code of the application.

## Step: 5

- Made changes in the application and pushed it to GitHub repo from dev branch.
  - Jenkins recognized the changes in the GitHub, it starts checking out the code and the build_and_push.sh will recognize that the dev branch has got updated and it starts building the code and pushed to capstone-dev repo in Docker Hub.
- Merged the updated code from dev to main.
  - Jenkins recognized the changes in the GitHub, it starts checking out the code and the build_and_push.sh will recognize that the main branch has got updated and it starts building the code and pushed to capstone-prod repo in Docker Hub.
- When the main got merged or updated, it will not only push the image to Docker Hub but the script in the Terraform code will execute to pull the image from the Docker Hub and start the container using the docker-compose.yaml file.
- And the Application will be updated in real time.

## Step: 6

- We have already copied over the prometheus.yml, alertmanager.yml and alert_rules.yml files using the Terraform code to it's appropriate location. Now just need to update the IP address of the Prometheus, AlertManager and Node Exporter.
- Once that done, Prometheus, AlertManager and Node Exporter will be up and running.
- When the application was running, have brought down the Node Exporter which is scraping the metrics from the EC2 Instance where our application is running.
- We have also configure Prometheus, AlertManager using yml file.
- As soon as the Node Exporter went down we were notified with an email.

**You can find all the configuration files here in this repository under Capstone Project.**

***I have also documented everything in a video format, if you could spare some time review it here https://iganeshkumar.duckdns.org/local/about/project/project.html***


