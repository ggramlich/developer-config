#!/bin/bash

if [ "$1" == "-doit" ]
then
    puppet --confdir `pwd` manifests/developer.pp
else
    puppet --confdir `pwd` --noop manifests/developer.pp
fi

