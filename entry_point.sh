#!/bin/bash
#
# IMPORTANT: Change this file only in directory Standalone!

source /opt/bin/functions.sh

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

SERVERNUM=$(get_server_num)

rm -f /tmp/.X*lock

# enable virtualenvwrapper
source "/usr/local/bin/virtualenvwrapper.sh" > /dev/null 2>&1
echo "enable virtualenvwrapper"

# collect env variables
NAME=$(grep -o -P "(?<=VIRTUAL_ENV=\"\/home\/)\w.+(?=\/\.)" /root/.virtualenvs/env/bin/activate)
HOSTENVNAME=$(grep -o -P '(?<=\/.virtualenvs\/)\w+' /root/.virtualenvs/env/bin/activate)
SHELLNAME=$(head -n 1 /root/.virtualenvs/env/bin/preactivate | awk -F "/" '{print $NF}')

# sed host venv path settings
#1. change to bash from zsh
sed -i -e 's/'"$SHELLNAME"'/bash/g' /root/.virtualenvs/env/bin/preactivate
#2. change to root from user folder
sed -i -e 's/VIRTUAL_ENV="\/home\/'"$NAME"'/VIRTUAL_ENV="\/root/g' /root/.virtualenvs/env/bin/activate
#3. change env name to 'env'
sed -i -e's@\.virtualenvs\/'"$HOSTENVNAME"'@\.virtualenvs\/env@g' /root/.virtualenvs/env/bin/activate

# use env
workon env
echo python: $(which python)

xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

#execute python code
python $@

trap shutdown SIGTERM SIGINT
# rollback
sed -i -e 's/bash/'"$SHELLNAME"'/g' /root/.virtualenvs/env/bin/preactivate
sed -i -e 's/VIRTUAL_ENV="\/root/VIRTUAL_ENV="\/home\/'"$NAME"'/g' /root/.virtualenvs/env/bin/activate
sed -i -e's@\.virtualenvs\/env@\.virtualenvs\/'"$HOSTENVNAME"'@g' /root/.virtualenvs/env/bin/activate

#clean up
rm -rf geckodriver.log
wait $NODE_PID
