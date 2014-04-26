#!/bin/bash
ROOT=`pwd`
QUERY_ROOT=$ROOT/$1
EXPERIMENTS_ROOT=$ROOT/results
RESULTS_FILE=$EXPERIMENTS_ROOT/anapsid-results-$(date +"%Y%m%d-%k:%M:%S")
ERRORS_FILE=$EXPERIMENTS_ROOT/anapsid-errors-$(date +"%Y%m%d-%k:%M:%S")
CMD_FILE=$ROOT/bin/runAnapsid.py
TIMEOUT=100
echo $RESULTS_FILE;
for endpoint in $(ls $QUERY_ROOT/owlim)
do
    echo $endpoint >> $RESULTS_FILE
    for query in $(ls $QUERY_ROOT/owlim/$endpoint/*.sparql)
    do
	(timeout -s 12 $TIMEOUT python $CMD_FILE \
            -e $QUERY_ROOT/owlim/$endpoint/endpoint.anapsid \
            -q $query \
            -p b \
            -s False \
            -b 16384 \
            -o False \
            -d SSGM \
            -a True \
            -w True \
            -t O)
        2>> $ERRORS_FILE
        >> $RESULTS_FILE;
    done
done

for endpoint in $(ls $QUERY_ROOT/virtuoso)
do
    echo $endpoint >> $RESULTS_FILE
    for query in $(ls $QUERY_ROOT/virtuoso/$endpoint/*.sparql)
    do
	(timeout -s 12 $TIMEOUT python $CMD_FILE \
            -e $QUERY_ROOT/virtuoso/$endpoint/endpoint.anapsid \
            -q $query \
            -p b \
            -s False \
            -b 16384 \
            -o False \
            -d SSGM \
            -a True \
            -w True \
            -t V)
        2>> $ERRORS_FILE
        >> $RESULTS_FILE;
    done
done
