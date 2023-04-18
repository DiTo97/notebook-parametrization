#!/bin/sh
#
# run_async_notebook.sh - It runs a notebook in the background
# ------------------------------------------------------------
# TODO: It should verify the S@ args
# TODO: It should add a usage message
notebook=$1
config=$2

parameters="configs/$config.yaml"

stdout="logs/$config.out"
stderr="logs/$config.err"

run_notebook="papermill $notebook - -f $parameters"
nohup $run_notebook 1> $stdout 2> $stderr &
