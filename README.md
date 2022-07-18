Docker demo

Created to demo Dockerfiles
 - How to create a Dockerfile
 - How to create an image from a Dockerflle
 - How to create a Docker container

## How to run the project

- Create  and activate a  virtual environment

- Install project dependencies

- Run the project by running
  ```bash
  python -m app.py
  ```

  



## How to build a Docker image: `docker build -t name_of_image:version .`

```bash
docker build -t hello_world:1.0 .
```
or 

```bash
docker build -t hello_world:1.0 -f Dockerfile  .
```

## How to create a Docker container from a docker image

```bash
docker run --name hello-udacians -p 5500:5000 -e FLASK_ENV=development -e FLASK_DEBUG=True hello_world:1.0
```

- -p flag publishes the application running on port 5000 within the docker container to be accessed via port 5500 on the host machine
- -e flag is used to specify environment variables
- --name is used to specify the name of the docker container, without it a random name is assigned to the container.



## Demo of Common errors with creating Docker files

### Always specify the base image version tag instead of latest.

 The file `broken.Dockerfile` builds on the latest python version using `broken_requirements.txt` file.
 The `broken_requirements.txt` file is called so for lack of a better name but it contains an application's requirements that runs on python 3.6
 Try building the docker image by running

 ```bash
 docker build -t image_build_will_fail -f broken.Dockerfile .
 ```
 As you can see, the build does not pass.
 When you change the image tag from latest to 3.6 to point to a specify python version 3.6, the build will pass
 ```bash
 docker build -t image_build_will_succeed -f broken.Dockerfile .
 ```
 > **Lesson learnt:** Always specify image tag version to a specific one to make your project fail proof in the future
 with regards to the environment in which it successfully runs.

### Order of Docker instructions matters

The `wrong_order.Dockerfile` has the instruction for installing requirements appearing before the `COPY` instruction that copies the `reqiuirements.txt` file.

```bash
docker build -t build_failed_wrong_order -f wrong_order.Dockerfile .
```

> **Lesson learnt:** Always ensure that you declare the docker instructions in the right order.