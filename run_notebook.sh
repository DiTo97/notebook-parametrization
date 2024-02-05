#!/bin/sh
#
# run_notebook - It runs notebook parametrization in the background
# -----------------------------------------------------------------
configdir="configs"
logdir="logs"
background=0

if [ $# -lt 2 ]; then
    echo "Error: not enough arguments"
    echo "Usage: $0 <notebook> <config> [--configdir <configdir>] [--logdir <logdir>] [--background]"
    exit 1
fi

notebook=$1
config=$2

shift 2

while (( "$#" )); do
    case "$1" in
        --configdir)
          configdir=$2
          shift 2
          ;;
        --logdir)
          logdir=$2
          shift 2
          ;;
        --background)
          background=1
          shift
          ;;
        *)
          echo "Error: invalid argument"
          echo "Usage: $0 <notebook> <config> [--configdir <configdir>] [--logdir <logdir>] [--background]"
          exit 1
    esac
done

parameters="$configdir/$config.yaml"

stdout="$logdir/$config.out"
stderr="$logdir/$config.err"

python preprocessing.py $notebook

run_notebook="papermill $notebook - -f $parameters"

mkdir -p $logdir/

if [ "$background" -eq 1 ]; then
    nohup $run_notebook 1> $stdout 2> $stderr &
else
    $run_notebook 1> $stdout 2> $stderr
fi
