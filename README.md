# WAT

Pipelines we use to build projects we found or created, mostly around docker images, concourse but also others.

Mostly all are also published for **Rancher** as Catalogs under our public [rancher-catalog](https://github.com/EugenMayer/docker-rancher-extra-catalogs)

## projects


### Rundeck

#### Rundeck Docker Image
Production grade Rundeck Server, more under https://github.com/EugenMayer/docker-image-rundeck

### Atlassian

#### Jira Docker Image
Production grade Jira-Server builds for all patched versions to be run in a docker container, more under https://github.com/EugenMayer/docker-image-atlassian-jira

#### Confluence Docker Image
Production grade Confluence-Server builds for all patched versions to be run in a docker container, more under https://github.com/EugenMayer/docker-image-atlassian-confluence

#### Bitbucket Docker Image
Production grade Bitbucket-Server for the recent releases to be run in a docker container, more under https://github.com/EugenMayer/docker-image-atlassian-bitbucket

### OPNsense

#### OPNsense-cli

A golang based opnsense cli to to remotely access the REST-API of opnsense or being using in a golang projects for automating 
OPNsense tasks as libarary. See https://github.com/EugenMayer/opnsense-cli for more

### Docker

#### Docker Client Image
Slim docker image to include docker-compose and the docker binary for remote docker operations, more under https://github.com/EugenMayer/docker-image-docker-client

### Concourse

#### concourse configurator

When starting a concourse-server you usually need to create some keys first, in case you have vault, you even need to do a lot more
and also setup all this manually. This is very interruptive and also makes spinning up local instances inconvinient, but much more then that,
build a rancher catalog for concourse would be very inconvenient. Thats is where the configurator helps a lot, i used it for

 - the rancher catalog : https://github.com/EugenMayer/docker-rancher-extra-catalogs/tree/master/templates/concourseci
 - and the boilerplate to instantly spinup a working concoure-server with a vault locally, very handy for developing pipelines: https://github.com/EugenMayer/concourseci-server-boilerplate

See https://github.com/EugenMayer/docker-image-concourse-configurator for more documentations and usage, or just see the boilerplate for a conrete example

#### concourse worker solid

Currently when running concourse-workers in non BOSH environments, like we do with `docker-compose`, see https://github.com/EugenMayer/concourseci-server-boilerplate
when you shutdown the stack for restart or upgrade, the worker becomes to be in a broken, undefined state, leading to a lot of different issues like

 - "file not found" when running a task /job in concourse or during a resource trigger
 - job / task is stalled / stuck in the "preparing build" state, not doing anything

What we do here is simply put, trap the worker and `concourse land-worker` before we kill / stop the worker-container
And thats about it

The docker-image can be found under [eugenmayer/concourse-worker-solid](https://hub.docker.com/r/eugenmayer/concourse-worker-solid/)


#### docker-image-resource-ng

Replaces / extends the core implementation of concourse [docker-image-resource](https://github.com/concourse/docker-image-resource) with [docker-image-resource-ng](https://github.com/EugenMayer/docker-image-resource-ng) to:

 - enable you to login into multiple private registries at the same time
 - which helps you building images which derive from image `1` form private registry `A` and pushing image `2` to registry B
 - avoids using `docker save/load` at all costs, since both are very slow and blocking - push / pull is a lot faster

Source can be found [here](https://github.com/EugenMayer/docker-image-resource-ng)
The docker-image can be found under [eugenmayer/concourse-docker-image-resource](https://hub.docker.com/r/eugenmayer/concourse-docker-image-resource/)

#### static-resource

Replaces / reimplements the `archive-resource` with [static-resource](https://github.com/EugenMayer/concourse-static-resource)

 - enables you to pull in static artefacts (fixed version) from any URL
 - supports basic auth for authentication
 - you can use this in a pipeline, not only in `execute`
 - enables you to upload a file using a mulitpart upload, e.g. for a `Sonatype nexus raw repository`

Source and docs can be found at [static-resource](https://github.com/EugenMayer/concourse-static-resource).The docker-image can be found under [eugenmayer/concourse-static-resource](https://hub.docker.com/r/eugenmayer/concourse-static-resource/)
