# use python:3.10-slim-bullseye as base image 
FROM python:3.10-alpine

#  Set working directory context
WORKDIR /app 

COPy requirements.txt .

RUN pip install -r requirements.txt

COPY app.py .


# Command for container to execute
ENTRYPOINT ["python", "app.py"]
