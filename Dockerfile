# Use the official Octopus Deploy image
FROM octopusdeploy/octopusdeploy:latest

# If you need custom config or scripts, COPY them here:
# COPY custom-script.ps1 /scripts/

# Ports in Octopus Deploy images are commonly 80 and 443.
# If you plan to serve on port 8080 internally, you'll configure it with environment vars.
