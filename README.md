# Pega Deployment On Kubernetes (Minikube)

The following are the steps to be followed to containerize Pega platform on Kubernetes and connecting to Postgress database server running on the Host machine. 

To gain some basic understanding on the deployment architecture please refer https://docs.pega.com/client-managed-cloud/85/understanding-pega-deployment-architecture

### Prerequisites

1. Request access for "My Pega Docker Image Access" from https://sm.pega.com.

2. Request for API access keys (For more details refer: https://docs.pega.com/client-managed-cloud/87/pega-provided-docker-images). Store UserId and API key in a secure location.

3. Make sure you have your own private docker registry to maintain your docker images. Generate APIKey to push images to your repository.

4. Download & install Pega Personal Edition https://community.pega.com/digital-delivery

5. Optional: Download and install pgAdmin https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.13/windows/pgadmin4-6.13-x64.exe

6. Get the script files locally https://github.com/KalyanasGitRepo/PegaOnKubernetes/archive/refs/heads/main.zip

### Install docker

7. Skip this step, if the docker desktop it is already installed. If not, run the script "1. Docker Install & Launch.ps1".
    
    a. Gets version of Docker Desktop Installer.exe
    
    b. Triggers Docker Desktop installation.
    
8. Restart your machine after step 5. Please make sure Docker Desktop launches successfully and runs docker in Linux Containers mode. 

### Install Minikube

9. Run the script ".\Scripts\Minikube Install and launch.ps1". This scripts performs the following tasks.

    a. Download latest version of Minikube from https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe

    b. Sets PATH environment variable to append Minikube installation path.

    c. Launches Minikube with 4 CPU, and 12 GB Memory units



### Install Helm Charts

10. Run the script ".\Scripts\3. Helm Charts Installation.ps1". This scripts performs the following tasks.

                a. Installs chocolatey
                
                b. Installs helm
                
                c. Sets PATH environment variable to append helm tools installation path.
                
 ### Prepare Pega docker images for your installation.
 

11. Run the script ".\Scripts\4. Prepare Docker Images.ps1". This scripts performs the following tasks.

          a. Login into Pega Docker Registry
          b. Pulls the image for Platform/pega
          b. Pulls the image for Platform/installer
          c. Pulls the image for Search n Reporting service
          d. Pulls the image for platform/clustering-service
          e. Tags images
          f. Login into your private Docker Registry.
          g. Pushes the tagged images into your private Docker registry
          
 ### Prepare Values for Pega Helm Charts
 
 12. Run the script ".\Scripts\5. Prepare Values for Pega Helm Charts.ps1". This scripts performs the following tasks.

          a. Add the Pega repository to your Helm installation.
          b. Get latest values-minimal.yaml
          
 13. Configure values-minimal.yaml file. You can make use of sample configuration (properly configured and it works) from ".\Configuration\Sample-values-minimal.yaml".  

 ### Deploy Pega on Kubernetes
 14. Run the script ".\Scripts\6. Deploy Pega on Kubernetes.ps1". This scripts performs the following tasks. 

          a. Create required namespace.
          b. Installs pega helm charts passing values-values.yaml.
          
          
 ### Check Deployment Status  & launch pega interface
 16. Various commands to check the overall deployment status and Pod logs

        kubectl get all --namespace=mypega
        
        kubectl describe  pod pega-app1-dev-minikube-0 --namespace=mypega
        
        kubectl describe  service pega-app1-dev-minikube --namespace=mypega
        
        kubectl logs pega-app1-dev-minikube-0 --namespace=mypega
        
    
  17 Run the following command to launch the service 
   
        minikube service pega-app1-dev-minikube --namespace=mypega
   
 # Key Points, Challenges & Solutions
 
 18. Key Points, Challenges & Solutions.

        a. Missing access rights on pega docker images repository. Raise a request for "My Pega Docker Image Access" from https://sm.pega.co and gained access to the repository.

        b. Make sure correct version of docker images are mentioned the values.yaml for pega, pega-installer, hazelcast & Search images.

        c. Probes timeout issues: Can be resolve by increasing initialDelaySeconds, timeoutSeconds, failureThreshold.

        d. Incorrect Jdbc DriverUri: Replaced with correct version of Jdbc driver. The one mentioned in the sample values-minimal.yaml file should work with latest version of pega.

        e. Connectivity issues between the host machine and Minikube pods & services. Make sure correct Host IP is mentioned for the Jdbc connection string.

        f. Make sure values-minimal.yaml is configured with sufficient CPU and memory units.

        g. Database connectivity issues: Make sure connection string is correctly configured with the Host IP and Port number. Please check if database service is up and running.



   
   
    

