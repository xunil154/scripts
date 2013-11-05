#!/bin/sh
timestamp=`date +%s`
date=`date`
diff=$(( $timestamp - $start_timestamp ))
echo -e "STOP:\t$bash_id\t$timestamp\t$date\t$diff" >> ~/.bash_session_log
