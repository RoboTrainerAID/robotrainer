#!/bin/bash
trap "kill 0" EXIT

command=$1
if [ -z "$1" ]; then
  echo "No command provided exiting!"
  exit
fi

file=$2
if [ -z "$2" ]; then
  echo "No file provided exiting."
  exit
fi

pid_file="$file.pid"

echo "" > $file
echo "" > $pid_file

started=false
parameter=""
pid=-1

while :
do 
    first_line=$(head -n 1 $file)  
    if [ "$first_line" = "START" ]  && [ "$started" = false ]; then
        second_line=$(head -n 2 $file | tail -1)
        IFS=' '
        read -ra data <<< "$second_line"
        parameter=${data[1]}
        echo "The command will be started with the parameter $parameter"
        ret_val=$($command)
        echo $ret_val
        pid=$?
        echo $pid
        echo $pid > $pid_file
        started=true
    elif [ "$first_line" = "STOP" ] && [ "$started" = true ]; then
        kill -15 $pid
        started=false
        pid=""
        echo "The command is stopped"
    fi
    if [ "$started" = true ]; then
        kill -0 $pid
        status=$?
        if [ "$stat" = "1" ]; then
            echo "Process with $pid has stopped!"
            echo $pid > $pid_file
        fi
    fi
    sleep 0.1
done
