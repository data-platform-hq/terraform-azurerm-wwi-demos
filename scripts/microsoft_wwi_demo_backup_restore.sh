#!/bin/bash

# INSTALL MSSQL SERVER
export MSSQL_PID=Developer 
export ACCEPT_EULA=Y 
export MSSQL_SA_PASSWORD='${mssql_sa_password}'

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
apt-get update -y
apt-get install -y mssql-server
/opt/mssql/bin/mssql-conf -n setup
systemctl status mssql-server --no-pager

# DOWNLOAD SQL SERVER TOOLS
if ! [[ "18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]];
then
    echo "Ubuntu $(lsb_release -rs) is not currently supported.";
    exit;
fi
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
export ACCEPT_EULA=Y
apt-get update
apt-get install -y msodbcsql18
apt-get install -y mssql-tools18

# DOWNLOAD WWI BACKUP
wget -O '/home/adminuser/wwi-op.bak' 'https://github.com/data-platform-hq/microsoft-wwi-demo-backups/releases/download/v0.0.1/WideWorldImporters-2023810-17-20-58.bak'

# RESTORE DB FROM BACKUP
/opt/mssql-tools18/bin/sqlcmd -C -S localhost -U SA -P ${mssql_sa_password} -Q "RESTORE FILELISTONLY FROM DISK = '/home/adminuser/wwi-op.bak'; RESTORE DATABASE [WideWorldImporters] FROM DISK = '/home/adminuser/wwi-op.bak' WITH MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf',MOVE 'WWI_UserData' TO '/var/opt/mssql/data/WideWorldImporters_userdata.ndf',MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf',MOVE 'WWI_InMemory_Data_1' TO '/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1'"
