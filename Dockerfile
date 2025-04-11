# Use Windows Server Core 2022 as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set shell to PowerShell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Environment variables
ENV OCTOPUS_VERSION=2024.3.11951 \
    OCTOPUS_HOME=C:\Octopus \
    OCTOPUS_ADMIN_USERNAME="admin" \
    OCTOPUS_ADMIN_PASSWORD="SecurePassword123!" \
    OCTOPUS_SQL_CONNECTION_STRING="Server=octopus-db.crufshaeq0ox.us-east-1.rds.amazonaws.comm;Database=OctopusDeploy;User Id=octopusadmin;Password=SecureDBPass123!;" \
    OCTOPUS_PORT=8080

# Create directories
RUN New-Item -ItemType Directory -Path $env:OCTOPUS_HOME; \
    New-Item -ItemType Directory -Path C:\Install

# Download Octopus Deploy installer
RUN Invoke-WebRequest -Uri "https://download.octopusdeploy.com/octopus/Octopus.$env:OCTOPUS_VERSION-x64.msi" -OutFile "C:\Install\Octopus.msi"

# Install Octopus Deploy silently
RUN Start-Process msiexec.exe -ArgumentList "/i C:\Install\Octopus.msi /quiet /norestart" -Wait

# Configure Octopus Deploy with trial
RUN & 'C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe' create-instance --instance default --config "$env:OCTOPUS_HOME\OctopusServer.config"; \
    & 'C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe' database --instance default --connectionString "$env:OCTOPUS_SQL_CONNECTION_STRING" --create; \
    & 'C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe' configure --instance default --home "$env:OCTOPUS_HOME" --port $env:OCTOPUS_PORT --noAnonymous; \
    & 'C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe' admin --instance default --username "$env:OCTOPUS_ADMIN_USERNAME" --password "$env:OCTOPUS_ADMIN_PASSWORD"; \
    & 'C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe' service --instance default --install --stop

# Expose web portal port
EXPOSE $env:OCTOPUS_PORT

# Run Octopus Deploy server
ENTRYPOINT ["C:\\Program Files\\Octopus Deploy\\Octopus\\Octopus.Server.exe", "run", "--instance", "default"]
