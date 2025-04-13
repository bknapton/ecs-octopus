# Use the official Octopus Deploy Docker image
FROM octopusdeploy/octopusdeploy:latest

# Accept the EULA
ENV ACCEPT_EULA=Y

# Connection string to your SQL Server database
ENV DB_CONNECTION_STRING="Server=db,1433;Initial Catalog=OctopusDeploy;Persist Security Info=False;User ID=sa;Password=P@ssw0rd123!;MultipleActiveResultSets=False;Connection Timeout=30;"

# Octopus admin credentials
ENV ADMIN_USERNAME="admin"
ENV ADMIN_PASSWORD="Password123!"
ENV ADMIN_EMAIL="admin@example.com"

# By default, Octopus stores data in /octopus
VOLUME /octopus

# Expose ports - usually 8080 (web portal) and 10943 (Tentacles)
EXPOSE 8080
EXPOSE 10943
