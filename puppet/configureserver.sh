#!/bin/bash

if [ "$1" == "-doit" ]
then
    puppet --confdir `pwd` manifests/server.pp
else
    puppet --confdir `pwd` --noop manifests/server.pp
fi

