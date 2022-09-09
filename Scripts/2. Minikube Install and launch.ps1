#1.Download latest version of Minikube
New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing

#2. Sets PATH environment valiable to appends Minikube installation path.
$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
if ($oldPath.Split(';') -inotcontains 'C:\minikube'){ `
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
}

[Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

#3. Launch Minikube with sufficient CPU and Memory
minikube config set driver docker
minikube start --cpus 4 --memory 12288