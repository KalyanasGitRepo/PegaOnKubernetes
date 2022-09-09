# Pega Deployment On Kubernetes (Minikube)

The following are the steps to be followed to containerize Pega platform on Kubernetes and connecting to Postgress database server running on the Host machine. 

To gain some basic understanding on the deployment architecture please refer https://docs.pega.com/client-managed-cloud/85/understanding-pega-deployment-architecture

### Prerequisites

1. Get the script files locally https://github.com/KalyanasGitRepo/PegaOnKubernetes/archive/refs/heads/main.zip  and extract the contents of the Zip file into D:\PegaOnKubernetes.

2. Request access for "My Pega Docker Image Access" from https://sm.pega.com.

3. Request for API access keys (For more details refer: https://docs.pega.com/client-managed-cloud/87/pega-provided-docker-images). Store UserId and API key in a secure location. We need these credentials for Step: 12

4. Make sure you have your own private docker registry to maintain your docker images. Generate APIKey to push images to your repository. We need these credentials for Step: 12

5. Request access for Pega Platform from https://my.pega.com/mypegaprd/PRAuth under my software section.

6. Download latest Pega Platform 8.7 compressed distribution image into "D:\PegaOnKubernetes\PegaInstaller\"  folder; and extract the compressed file into the same folder. 

### Install docker

7. Skip this step, if the docker desktop it is already installed. If not, run the script "1. Docker Install & Launch.ps1". This script performs the following tasks.
    
    a. Gets version of Docker Desktop Installer.exe
    
    b. Triggers Docker Desktop installation.
    
8. Restart your machine after step 5. Please make sure Docker Desktop launches successfully and runs docker in Linux Containers mode. 

### Install Minikube

9. Run the script ".\Scripts\Minikube Install and launch.ps1". This script performs the following tasks.

    a. Download latest version of Minikube from https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe

    b. Sets PATH environment variable to append Minikube installation path.

    c. Launches Minikube with 4 CPU, and 12 GB Memory units

### Install Helm Charts

10. Run the script ".\Scripts\3. Helm Charts Installation.ps1". This script performs the following tasks.

                a. Installs chocolatey
                
                b. Installs helm
                
                c. Sets PATH environment variable to append helm tools installation path.
                
 ### Prepare Pega docker images for your installation.
 

11. Run the following command with the correct parameter values. This script performs the tasks mentioned below.

    Command: 
    
    ./Scripts/"4. Prepare Docker Images.ps1" pegaRegistryUserId pegaRegistryAPIKey pesonalRegistryUserId pesonalRegistryAPIKey

          a. Login into Pega Docker Registry
          b. Pulls the image for Platform/pega
          b. Pulls the image for Platform/installer
          c. Pulls the image for Search n Reporting service
          d. Pulls the image for platform/clustering-service
          e. Tags images
          f. Login into your private Docker Registry.
          g. Pushes the tagged images into your private Docker registry
 
 ### Prepare Postgres Database Server 
 
12. Install Postgres database server (listening on Port: 5432) from https://www.enterprisedb.com/postgresql-tutorial-resources-training?uuid=db55e32d-e9f0-4d7c-9aef-b17d01210704&campaignId=7012J000001NhszQAC

 
13. To allow remote connections, append the following line to the file C:\Program Files\PostgreSQL\14\data\pg_hba.conf. 
    Please check the sample file Configuration\pg_hba.conf for your reference.

host    all     all             0.0.0.0/0            md5

host    all     all             ::/0            md5
 
14.  Optional: For any additional logging or tracing customize the following lines  in the files C:\Program Files\PostgreSQL\14\data\postgres.conf 

    Please check the sample file Configuration\postgres.conf for your reference. Caution: These setting can consume excessive disk space
    
        log_statement = 'all' 
        log_directory = 'log'
        log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
        log_min_error_statement = error
        log_line_prefix = 'ip %h, usr %u, time %t, pid %p %q db %d, app %a, line %l '

15. Restart the postgres database service. 

    Restart-Service -DisplayName 'postgresql-x64-14 - PostgreSQL Server 14'

16. Run the script ".\Scripts\6. Database-Schema-Users.ps1". This script performs the following tasks. 

          a. Sets Path environment variable.
          b. Creates "pegadb" empty database
          c. Creates users ("base-user", "admin-user") with required privileges.
          d. Creates schemas "data", "rules"
          e. Downloads JDBC Driver for Postgres into "C:\PostgresJDBCDriver\postgresql-42.5.0.jar". This file location will be used in the configuration of next step. 

17. Configure \117271_Pega8.7.3\scripts\setupDatabase.properties file. For more details please refer the sample configuration at \Configuration\setupDatabase.properties

18. Run the script ".\Scripts\"7. Load-Rules-Data-Schemas.ps1". This script invokes "install.bat".

 ### Prepare Values for Pega Helm Charts
 
 19. Run the script ".\Scripts\5. Prepare Values for Pega Helm Charts.ps1". This script performs the following tasks.

          a. Add the Pega repository to your Helm installation.
          b. Get latest values-minimal.yaml
          
 20. Configure values-minimal.yaml file. You can make use of sample configuration (properly configured and it works) from ".\Configuration\Sample-values-minimal.yaml".  

 ### Deploy Pega on Kubernetes
 21. Run the script ".\Scripts\8. Deploy Pega on Kubernetes.ps1". This script performs the following tasks. 

          a. Create required namespace.
          b. Installs pega helm charts passing values-values.yaml.
          
          
 ### Check deployment status  & launch pega interface
 22. Various commands to check the overall deployment status and Pod logs

        kubectl get all --namespace=mypega
        
        kubectl describe  pod pega-app1-dev-minikube-0 --namespace=mypega
        
        kubectl describe  service pega-app1-dev-minikube --namespace=mypega
        
        kubectl logs pega-app1-dev-minikube-0 --namespace=mypega
        
    
  23 Run the following command that launches pega platform on the browser. 
   
        minikube service pega-app1-dev-minikube --namespace=mypega
   
 # Key Points, Challenges & Solutions
 
 24. Key Points, Challenges & Solutions.

        a. Missing access rights on pega docker images repository. Raise a request for "My Pega Docker Image Access" from https://sm.pega.co and gained access to the repository.

        b. Make sure correct version of docker images are mentioned the values.yaml for pega, pega-installer, hazelcast & Search images.

        c. Probes timeout issues: Can be resolve by increasing initialDelaySeconds, timeoutSeconds, failureThreshold.

        d. Incorrect Jdbc DriverUri: Replaced with correct version of Jdbc driver. The one mentioned in the sample values-minimal.yaml file should work with latest version of pega.

        e. Connectivity issues between the host machine and Minikube pods & services. Make sure correct Host IP is mentioned for the Jdbc connection string.

        f. Make sure values-minimal.yaml is configured with sufficient CPU and memory units.

        g. Database connectivity issues: Make sure connection string is correctly configured with the Host IP and Port number. Please check if database service is up and running.


