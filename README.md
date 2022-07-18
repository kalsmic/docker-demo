

# Docker demo

Table of Contents
=================
  - [How to run the project](#how-to-run-the-project)
    * [Create the virtual environment](#create-the-virtual-environment)
    * [Activate the virtual environment](#activate-the-virtual-environment)
    * [Deactivate the virtual environment](#deactivate-the-virtual-environment)
  - [How to build a Docker image: `docker build -t name_of_image:version .`](#how-to-build-a-docker-image-docker-build--t-name_of_imageversion-)
  - [How to create a Docker container from a docker image](#how-to-create-a-docker-container-from-a-docker-image)
  - [Demo of Common errors with creating Docker files](#demo-of-common-errors-with-creating-docker-files)
    - [Always specify the base image version tag instead of latest.](#always-specify-the-base-image-version-tag-instead-of-latest)
    - [Order of Docker instructions matters](#order-of-docker-instructions-matters)
    - [Impact of  a  `.dockerignore`  file](#impact-of--a--dockerignore--file)

## How to run the project

 1. ### Create the virtual environment

   ```bash
   python -m venv venv
   ```

1. ### Activate the virtual environment

   - for windows

   ```bash
   venv\Scripts\activate
   ```

   - for Linux / macOS

   ```bash
   source venv/bin/activate
   ```

2. ### Deactivate the virtual environment

   ```bash
   deactivate
   ```

- Install project dependencies

- Run the project by running
  ```bash
  python -m app.py
  ```

## How to build a Docker image: `docker build -t name_of_image:version -f name_of_dockerfile .`

```bash
docker build -t hello_world:1.0 .
```

You can leave out the `-f` flag if your docker file is so named `Dockerfile` and is in the current 

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

### Impact of  a  `.dockerignore`  file
Build the project again
```bash 
docker build -t HelloWorld:1.0  -f complete.Dockerfile .
```
**Take note of the size of  build context and the final image**
Delete the `.dockerignore` file and build the project again

```bash 
docker build -t HelloWorld:1.1  -f complete.Dockerfile .
```
**Take note of the size of the build context and the final image**
Run `docker images`
Compare size of image `HelloWorld:1.0` with `HelloWorld:1.1`

`HelloWorld:1.1`  had  a bigger build context and also larger image size than `HelloWorld:1.0`

> **Lesson learnt:** The `.dockerignore` file helps us exclude unwanted files from the build context and as a result we are going to have a smaller build context (the set of files located in the specified PATH or URL)
reusulting and smaller image size as well since  the `COPY` instruction will have a much smaller scoped reference to a file in the context.

> This makes a difference if you are copying all files like it is with the `complete.Dockerfile` whereas with the simple `Dockerfile` provided in the repo where you specify individual files to copy, only the build context will be affected but the image size will not change since there's no avenue for copying any unnecessary files.
Bigger projects usually have many files and copying them one by one is against the convention and would result in more layers. Remember every instruction in a `dockerfile` is a layer.
