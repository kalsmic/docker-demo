# use python:3.10-slim-bullseye as base image 
FROM python:3.10


#  Set working directory context
WORKDIR /app 




RUN pip install --upgrade pip

#  Install dependencies
RUN pip install -r requirements.txt


# Copy the entire project (.) to /app in the container
# This layer is rebuilt when a file changes in the project directory
COPY . .

# Command for container to execute
ENTRYPOINT ["python", "app.py"]