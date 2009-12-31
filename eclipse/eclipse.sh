#!/bin/sh
export ECLIPSE_HOME=/home/gramlich/eclipse
export GDK_NATIVE_WINDOWS=true # workaround for Karmic - http://bit.ly/T8MIc
$ECLIPSE_HOME/eclipse $*

