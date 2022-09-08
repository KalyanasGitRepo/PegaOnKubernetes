# PegaOnKubernetes

1. Download & Install Pega Personal Edition https://community.pega.com/digital-delivery

2. Optional: Download and install pgAdmin https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.13/windows/pgadmin4-6.13-x64.exe

3. Get the script files locally https://github.com/KalyanasGitRepo/PegaOnKubernetes/archive/refs/heads/main.zip

### Install docker

4. Skip this step, if the docker desktop it is already installed. If not, run the script "1. Docker Install & Launch.ps1".
    
    a. Gets version of Docker Desktop Installer.exe
    
    b. Triggers Docker Desktop installation.
    
 5. Restart your machine after step 5. Please make sure Docker Desktop launches successfully and runs docker in Linux Containers mode. 

### Install Minikube

6. Run the script ".\Scripts\Minikube Install and launch.ps1". This scripts performs the following tasks.

    a. Download latest version of Minikube from https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe

    b. Sets PATH environment valiable to appends Minikube installation path.

    c. Launches Minikube with 4 CPU, and 12 GB Memory units



### Install Helm Charts

7. Run the script ".\Scripts\3. Helm Charts Installation.ps1". This scripts performs the following tasks.

                a. Installs chocolatey
                
                b. Installs helm
                
                c. Sets PATH environment valiable to appends helm tools installation path.
               
