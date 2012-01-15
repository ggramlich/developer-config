#!/bin/bash

if [ "$1" == "-doit" ]
then
    puppet apply --confdir `pwd` manifests/developer.pp
else
    puppet apply --confdir `pwd` --noop manifests/developer.pp
fi

