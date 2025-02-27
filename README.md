# Dockerfile for gprMax

## This README.md file needs to be updated. New scripts added.

Run [gprMax](https://github.com/gprmax/gprMax) models in a Docker container.

## Why?

* Install and run gprMax models easily on Windows, Mac OS, and Linux.
* Ideal for deployments to containerised web services like Amazon ECS.

## Installation

Install [Docker](https://docs.docker.com/get-docker/)

Clone this repository

```
git clone https://github.com/lomcin/docker-gprmax.git 
```

and navigate to the repository on your system

```
cd docker-gprmax
```

## Running a model

This repository contains an example model, ```model.in``` which simulates the response of a Hertzian dipole over a half-space containing a metal cylinder.

To run the model enter the following command in a Terminal (Linux/Mac OS) or Windows PowerShell (Windows):

```bash
docker run -v ${PWD}:/app maggi10/gprmax:latest model.in
```

gprMax will now run inside a docker container. The simulation output files will be saved in the current directory.

```
.
├── Dockerfile
├── README.md
├── cylinder_half_space.vti
├── model.in
├── model.out
└── requirements.txt
```
Different models can be run by copying the `.in` file into the current directory, running the above command and replacing ```model.in``` with the name of the new model. For example, the command for a new model ```my_new_model.in``` is:

```bash
docker run -v ${PWD}:/app maggi10/gprmax:latest my_new_model.in
```

The command has 3 actions:

1. Pull the maggi10/gprmax image from Docker Hub (if it's the first time the command has been run).
2. Mount the local directory in the Docker container under /app.
3. Run gprMax on the maggi10/gprmax image in a container with the specified parameters.

The container can be run from anywhere on your system. i.e. you do not need the Dockerfile. Just make sure you have a model file in the same directory as you're running the container.

## Additional Parameters
standard gprMax parameters can be added to the end of above command. For example, the geometry of the simulation can be tested without running gprMax by running

```bash
docker run -v ${PWD}:/app maggi10/gprmax:latest model.in --geometry-only
```

In this case the only output is the geometry file ```cylinder_half_space.vti```

```
.
├── Dockerfile
├── README.md
├── cylinder_half_space.vti
├── model.in
└── requirements.txt
```

## Rebuild the image

Currently the docker image is pulled from Docker Hub. To rebuild the image run.

```
docker build -t dockergprmax:latest .
```

Run new image:

```bash
docker run -v ${PWD}:/app dockergprmax:latest model.in
```

## Using gprMax? Cite us
If you use gprMax and publish your work we would be grateful if you could cite our work using:

Warren, C., Giannopoulos, A., & Giannakis I. (2016). gprMax: Open source software to simulate electromagnetic wave propagation for Ground Penetrating Radar, Computer Physics Communications (http://dx.doi.org/10.1016/j.cpc.2016.08.020)

