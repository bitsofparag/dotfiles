# Docker container to provide java sdk services

FROM store/oracle/serverjre:8

# Get the java project path from the compose file or command line
ARG project
ARG sdk_path

# Create a project path in the image where the codebase will be mounted
RUN ["sh", "-c", "mkdir -p $sdk_path"]
