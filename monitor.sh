#/usr/bin/bash

echo "start monitor node..."
echo "start">err.log

for ((i=0;1<2;i++)); do

    echo "monitoring..."

    if ! [[ $(netstat -an | grep 3001) ]] ; then

        echo "node server failed. restart...."
        echo "---------------------------">>err.log
        echo $(cat z.log) >>err.log

        nohup node src/bin/www > z.log 2>&1 &

    fi

    sleep 3
done
