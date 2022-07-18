# use python:3.10-slim-bullseye as base image 
FROM python:latest


#  Set working directory context
WORKDIR /app 

# Copy the entire project (.) to /app in the container
# This layer is rebuilt when a file changes in the project directory
COPY . .


RUN pip install --upgrade pip

#  Install dependencies
RUN pip install -r broken_requirements.txt




# Command for container to execute
ENTRYPOINT ["python", "app.py"]