# use python:3.10-slim-bullseye as base image 
FROM python:3.10-alpine

#  Set working directory context
WORKDIR /app 

# Set the VIRTUAL_ENV directory to a VIRTUAL_ENV variable
ENV VIRTUAL_ENV=/opt/venv

# Create a virtual environment
RUN python -m venv $VIRTUAL_ENV

# Add the VIRTUAL_ENV/bin to the PATH
# PATH is list of directories which are searched for commands to run
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Upgrade pip 
RUN pip install --upgrade pip

# Copy the entire project (.) to /app in the container
# This layer is rebuilt when a file changes in the project directory
COPY . .

#  Install dependencies
RUN pip install -r requirements.txt

# Indicates the port on which the container listens 
EXPOSE 5000

# Declares a default value for the DEBUG variable
ENV DEBUG False

# Command for container to execute
ENTRYPOINT ["python", "app.py"]
