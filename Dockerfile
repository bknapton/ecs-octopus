# Use the official Octopus Deploy Docker image
FROM octopusdeploy/octopusdeploy:latest

# Accept the EULA
ENV ACCEPT_OCTOPUS_EULA="Y"

# Expose default ports for Octopus (change if you configure differently)
EXPOSE 8080
EXPOSE 10943
