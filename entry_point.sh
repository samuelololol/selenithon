#!/bin/bash
#
# IMPORTANT: Change this file only in directory Standalone!

rm -f /tmp/.X*lock

# enable virtualenvwrapper
source "/usr/local/bin/virtualenvwrapper.sh" > /dev/null 2>&1
echo "enable virtualenvwrapper"

# debug
echo "ENV_NAME_@ACTIVATE:" $(grep -o -P '(?<=\/.virtualenvs\/)\w+' /root/.virtualenvs/env/bin/activate)
echo "HOME_NAME_@PIP:" $(grep -o -P "(?<=\#\!).+(?=\/\.virtualenvs)" /root/.virtualenvs/env/bin/pip)
echo "SHELL_NAME_@PREACTIVATE:" $(head -n 1 /root/.virtualenvs/env/bin/preactivate | awk -F "/" '{print $NF}')

# use env
workon env
echo python: $(which python)

Xvfb -ac :99 -screen 0 1280x1024x24 &
export DISPLAY=:99

if [[ "$1" == "bash" ]]
then
    ${@:2}
else
    python $@
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
