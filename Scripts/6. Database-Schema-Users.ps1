
#1. Sets PATH environment valiable to appends Minikube installation path.
$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
if ($oldPath.Split(';') -inotcontains 'C:\Program Files\PostgreSQL\14\bin'){ `
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\Program Files\PostgreSQL\14\bin' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
}

#2. Create pegadb, schemas and users

psql -h localhost -p 5432 -U postgres -f "./Configuration/Database-Schema-Users.sql"

New-Item -Path 'C:\' -Name 'PostgresJDBCDriver' -ItemType Directory -Force
Invoke-WebRequest -OutFile 'C:\PostgresJDBCDriver\postgresql-42.5.0.jar' -Uri 'https://jdbc.postgresql.org/download/postgresql-42.5.0.jar' -UseBasicParsing
