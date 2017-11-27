#!/bin/bash
fly sp -t kwinfra configure -c pipeline.yml -p open-source --load-vars-from versions.yml