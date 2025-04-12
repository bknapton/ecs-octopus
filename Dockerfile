# Use the official Octopus Deploy image
FROM octopusdeploy/octopusdeploy:latest

# If you need custom config or scripts, copy them here:
# COPY custom-script.ps1 /scripts/

# Expose port 8080 for clarity (optional)
EXPOSE 8080

# The official image sets up Octopus Deploy on port 80/443 by default
# but we override it via environment variables in the ECS task definition (OCTOPUS_PORT=8080).
