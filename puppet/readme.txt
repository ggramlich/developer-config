change to this puppet directory


to show applicable changes run

puppet --confdir `pwd` --noop manifests/developer.pp


to apply the changes run

sudo puppet --confdir `pwd` manifests/developer.pp
