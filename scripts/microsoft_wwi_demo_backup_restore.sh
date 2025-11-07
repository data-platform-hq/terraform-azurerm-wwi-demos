#!/bin/bash

# INSTALL MSSQL SERVER
export MSSQL_PID=Developer
export ACCEPT_EULA=Y
export MSSQL_SA_PASSWORD="${mssql_sa_password}"

curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | sudo tee /etc/apt/sources.list.d/mssql-server.list
curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

apt-get update -y
apt-get install -y mssql-server
apt-get install -y mssql-tools18 unixodbc-dev

/opt/mssql/bin/mssql-conf setup <<< "2"

systemctl status mssql-server --no-pager

for i in {1..60}; do
  if /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P "${mssql_sa_password}" -Q "SELECT 1" &>/dev/null; then
    echo "SQL Server is ready!"
    break
  fi
  echo "Waiting for SQL Server to start..."
  sleep 10
done

# DOWNLOAD WWI BACKUP
wget -O '/home/adminuser/wwi-op.bak' 'https://github.com/data-platform-hq/microsoft-wwi-demo-backups/releases/download/v0.0.1/WideWorldImporters-2023810-17-20-58.bak'

mv /home/adminuser/wwi-op.bak /var/opt/mssql/data/
chown mssql:mssql /var/opt/mssql/data/wwi-op.bak

# RESTORE DB FROM BACKUP
/opt/mssql-tools18/bin/sqlcmd -C -S localhost -U SA -P "${mssql_sa_password}" -Q "
RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/data/wwi-op.bak';

RESTORE DATABASE [WideWorldImporters]
FROM DISK = '/var/opt/mssql/data/wwi-op.bak'
WITH
MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf',
MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImporters_userdata.ndf',
MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf',
MOVE 'WWI_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1';
"
