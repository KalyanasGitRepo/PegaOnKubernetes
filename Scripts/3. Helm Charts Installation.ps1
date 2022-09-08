    #1. Install chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    #2. Install helm
    choco install kubernetes-helm

    #3. Set Path environment variable
     $oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
    if ($oldPath.Split(';') -inotcontains 'C:\ProgramData\chocolatey\lib\kubernetes-helm\tools'){ `
    [Environment]::SetEnvironmenVariable('Path', $('{0};C:\ProgramData\chocolatey\lib\kubernetes-helm\tools' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
    }
