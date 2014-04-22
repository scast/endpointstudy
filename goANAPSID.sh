#!/bin/bash
ROOT=`pwd`
QUERY_ROOT=$ROOT/experiment1
EXPERIMENTS_ROOT=$ROOT/results
RESULTS_FILE=$EXPERIMENTS_ROOT/anapsid-results-$(date +"%Y%m%d-%k:%M:%S")
ERRORS_FILE=$EXPERIMENTS_ROOT/anapsid-errors-$(date +"%Y%m%d-%k:%M:%S")
CMD_FILE=$ROOT/bin/runAnapsid.py
echo $RESULTS_FILE;
for endpoint in $(ls $QUERY_ROOT/)
do
    echo $endpoint >> $RESULTS_FILE
    for query in $(ls $QUERY_ROOT/$endpoint/*.sparql)
    do
	(timeout -s 12 300 python $CMD_FILE -e $QUERY_ROOT/$endpoint/endpoint.anapsid -q $query -p b -s False -b 16384 -o False -d SSGM -a True -w True) 2>> $ERRORS_FILE >> $RESULTS_FILE;
    done
done
