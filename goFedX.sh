#!/bin/bash
ROOT=`pwd`
QUERY_ROOT=$ROOT/$1
EXPERIMENTS_ROOT=$ROOT/results
RESULTS_FILE=$EXPERIMENTS_ROOT/fedx-results-$(date +"%Y%m%d-%H:%M:%S")
ERRORS_FILE=$EXPERIMENTS_ROOT/fedx-errors-$(date +"%Y%m%d-%H:%M:%S")
FEDX_ROOT=/home/anapsid/FedX-3.0.1
CMD_FILE=$ROOT/bin/runFedX.py
echo $RESULTS_FILE;
for endpoint in $(ls $QUERY_ROOT)
do
    echo $endpoint >> $RESULTS_FILE
    for query in $(ls $QUERY_ROOT/$endpoint/*.sparql)
    do
    	# echo $query
    	(python $CMD_FILE $query $QUERY_ROOT/$endpoint/endpoint.fedx $FEDX_ROOT) 2>> $ERRORS_FILE >> $RESULTS_FILE
    done
done
