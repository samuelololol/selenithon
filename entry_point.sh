#!/bin/bash
#
# IMPORTANT: Change this file only in directory Standalone!

rm -f /tmp/.X*lock
Xvfb -ac :99 -screen 0 1280x1024x24 &
export DISPLAY=:99

if [[ "$1" == "bash" ]]
then
    ${@:2}
else
    source /root/.virtualenvs/env/bin/activate
    pip3 install -r /app/requirements.txt
    python3 $@
fi
NODE_PID=$!

# trap shutdown SIGTERM SIGINT
# rollback
# wait $NODE_PID

# echo "wait 5 secs to leave"
# sleep 5

#clean up
#rm -rf geckodriver.log
[[ -n "$USER_ID"  ]] && chown -R ${USER_ID}:${USER_ID} /app/*
