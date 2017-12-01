#!/bin/bash
fly sp -t kwopensource configure -c pipeline.yml -p open-source --load-vars-from versions.yml