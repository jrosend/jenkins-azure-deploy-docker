FROM jenkins/jenkins:latest as myjenkins
USER root
RUN apt update

# Install jq
RUN apt install jq

# Install Azure CLI 
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Bicep
RUN az bicep install

# Install Python
RUN apt install python3 -y
RUN apt install python3-pip -y
RUN python3 -m pip install --upgrade pip

# Install Databricks python CLI
RUN python3 -m pip install databricks-cli

#Install Flake8
RUN python3 -m pip install flake8

# Install Powershell
RUN apt install -y wget apt-transport-https software-properties-common
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt update -y
RUN apt install -y powershell

# Install Powershell Azure CLI 
RUN ["pwsh", "-c", "Install-Module -Name Az -Scope AllUsers -Repository PSGallery -Force"]

# Install DotNet
RUN wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb 
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt install -y apt-transport-https
RUN apt install -y dotnet-sdk-3.1

# Install Azure Data Studio
RUN apt install -y libnss3 gnupg libxkbfile1 libsecret-1-0 libgtk-3-0 libxss1 libgbm1 libunwind8
RUN wget -progress=bar:force -q -O azuredatastudio-linux.deb https://go.microsoft.com/fwlink/?linkid=2168339 
RUN dpkg -i azuredatastudio-linux.deb
RUN rm azuredatastudio-linux.deb

# Install Sql Package
RUN apt install libunwind8
RUN curl -Lo sqlpackage-linux.zip https://aka.ms/sqlpackage-linux
RUN unzip -o sqlpackage-linux.zip -d /opt/sqlpackage/
RUN chmod +x /opt/sqlpackage/*
RUN rm -f /bin/sqlpackage
RUN ln -s /opt/sqlpackage/sqlpackage /bin/sqlpackage
RUN rm -rf sqlpackage-linux.zip
