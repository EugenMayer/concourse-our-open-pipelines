# WAT

Pipelines we use to build projects we found or created, mostly around concourse but also others

## projects

### concourse configurator

When starting a concourse-server you usually need to create some keys first, in case you have vault, you even need to do a lot more
and also setup all this manually. This is very interruptive and also makes spinning up local instances inconvinient, but much more then that,
build a rancher catalog for concourse would be very inconvenient. Thats is where the configurator helps a lot, i used it for

 - the rancher catalog : https://github.com/EugenMayer/docker-rancher-extra-catalogs/tree/master/templates/concourseci
 - and the boilerplate to instantly spinup a working concoure-server with a vault locally, very handy for developing pipelines: https://github.com/EugenMayer/concourseci-server-boilerplate

See https://github.com/EugenMayer/docker-image-concourse-configurator for more documentations and usage, or just see the boilerplate for a conrete example

### concourse worker solid

Currently when running concourse-workers in non BOSH environments, like we do with `docker-compose`, see https://github.com/EugenMayer/concourseci-server-boilerplate
when you shutdown the stack for restart or upgrade, the worker becomes to be in a broken, undefined state, leading to a lot of different issues like

 - "file not found" when running a task /job in concourse or during a resource trigger
 - job / task is stalled / stuck in the "preparing build" state, not doing anything

What we do here is simply put, trap the worker and `concourse land-worker` before we kill / stop the worker-container
And thats about it

The docker-image can be found under [eugenmayer/concourse-worker-solid](https://hub.docker.com/r/eugenmayer/concourse-worker-solid/)


### docker-image-resource-ng

Replaces / extends the core implementation of concourse [docker-image-resource](https://github.com/concourse/docker-image-resource) with [docker-image-resource-ng](https://github.com/EugenMayer/docker-image-resource-ng) to:

 - enable you to login into multiple private registries at the same time
 - which helps you building images which derive from image `1` form private registry `A` and pushing image `2` to registry B
 - avoids using `docker save/load` at all costs, since both are very slow and blocking - push / pull is a lot faster

Source can be found [here](https://github.com/EugenMayer/docker-image-resource-ng)
The docker-image can be found under [eugenmayer/concourse-docker-image-resource](https://hub.docker.com/r/eugenmayer/concourse-docker-image-resource/)

### static-download-resource

Replaces / reimplements the `archive-resource` with [static-download-resource](https://github.com/EugenMayer/concourse-static-download-resource)

 - enables you to pull in static artefacts (fixed version) from any URL
 - supports basic auth for authentication
 - you can use this in a pipeline, not only in `execute`

Source and docs can be found at [static-download-resource](https://github.com/EugenMayer/concourse-static-download-resource).The docker-image can be found under [eugenmayer/concourse-static-download-resource](https://hub.docker.com/r/eugenmayer/concourse-static-download-resource/)
