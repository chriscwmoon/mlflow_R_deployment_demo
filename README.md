# MLflow R Model Deployment Demo

*Chris Moon*

*Aug 25, 2019*

## Description:


## Requirements:
Before build a docker image, please have following 3 files in a same directory:
* Dockerfile
* MLmodel
* crate.bin

## Docker quickstart:

Build a docker image :
      docker build --rm -t <image name> <path to Dockerfile/modelfiles>

Run an image:
      docker run --rm -P <image name>

Find currently running containers:
      docker ps -a

Validate the running docker:
      docker exec -it <containerID> <command to run>
