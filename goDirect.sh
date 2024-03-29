#!/bin/bash
ROOT=`pwd`
QUERY_ROOT=$ROOT/$1
EXPERIMENTS_ROOT=$ROOT/results
RESULTS_FILE=$EXPERIMENTS_ROOT/direct-results-$(date +"%Y%m%d-%H:%M:%S")
ERRORS_FILE=$EXPERIMENTS_ROOT/direct-errors-$(date +"%Y%m%d-%H:%M:%S")
CMD_FILE=$ROOT/bin/runDirect.py
echo $RESULTS_FILE;

for endpoint in $(ls $QUERY_ROOT)
do
    echo $endpoint >> $RESULTS_FILE
    for query in $(ls $QUERY_ROOT/$endpoint/*.sparql)
    do
      	(python $CMD_FILE $query $QUERY_ROOT/$endpoint/endpoint.arq --timeout 100) 2>> $ERRORS_FILE >> $RESULTS_FILE
    done
done
