    #1. Get Docker Installer
    New-Item -Path 'c:\' -Name 'docker' -ItemType Directory -Force
    Invoke-WebRequest -OutFile 'c:\docker\Docker Desktop Installer.exe' -Uri 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe' -UseBasicParsing
    
    #2 Trigger installation
    Start-Process 'c:\docker\Docker Desktop Installer.exe' -Wait install
    
    
    #3. Restart-Computer
    #Restart-Computer

    #4. Start Docker desktop in linux container mode
    #Start-process "C:\Program Files\Docker\Docker\Docker Desktop.exe"