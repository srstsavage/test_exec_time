#!/bin/bash
if [[ $# -lt 3 ]]; then
  echo "Usage: report_threshold_ms loop_sleep_seconds command_to_test"
  echo "Prints timestamp, exec time, and exit code if exec time is"
  echo "greater than or equal to report threshold in ms"
  exit 1
fi

THRESHOLD=$1
shift
SLEEPTIME=$1
shift
CMD=$@

while true; do
  EXECTS=`date +%FT%T`
  EXECSTART=`date +%s%3N`
  eval "$CMD" > /dev/null
  RESULT=$?
  EXECTIME=$(($(date +%s%3N) - $EXECSTART))
  if [[ "$RESULT" -gt "0" ]] || [[ "$EXECTIME" -ge "$THRESHOLD" ]]; then
    echo $EXECTS $EXECTIME $RESULT
  fi
  sleep $SLEEPTIME
done
