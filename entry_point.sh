#!/bin/bash
#
# IMPORTANT: Change this file only in directory Standalone!


rm -f /tmp/.X*lock

# enable virtualenvwrapper
source "/usr/local/bin/virtualenvwrapper.sh" > /dev/null 2>&1
echo "enable virtualenvwrapper"
# collect env variables
export NAME=$(grep -o -P "(?<=VIRTUAL_ENV=\"\/Users\/)\w.+(?=\/\.)|(?<=VIRTUAL_ENV=\"\/home\/)\w.+(?=\/\.)" /root/.virtualenvs/env/bin/activate)
export HOSTENVNAME=$(grep -o -P '(?<=\/.virtualenvs\/)\w+' /root/.virtualenvs/env/bin/activate)
export SHELLNAME=$(head -n 1 /root/.virtualenvs/env/bin/preactivate | awk -F "/" '{print $NF}')
export HOSTHOMEPATH=$(grep -o -P "(?<=\#\!).+(?=\/\.virtualenvs)" /root/.virtualenvs/env/bin/pip)
#echo NAME:$NAME
#echo HOSTENVNAME:$HOSTENVNAME
#echo SHELLNAME:$SHELLNAME

# sed host venv path settings
#1. change to bash from zsh
sed -i -e 's@'"$SHELLNAME"'@bash@g' /root/.virtualenvs/env/bin/preactivate 2>&1
#2. change to root from user folder
sed -i -e 's@VIRTUAL_ENV="\/home\/'"$NAME"'@VIRTUAL_ENV="\/root@g' /root/.virtualenvs/env/bin/activate
sed -i -e 's@'"$HOSTHOMEPATH"'@\/root@g' /root/.virtualenvs/env/bin/pip
#3. change env name to 'env'
sed -i -e 's@\.virtualenvs\/'"$HOSTENVNAME"'@\.virtualenvs\/env@g' /root/.virtualenvs/env/bin/activate
sed -i -e 's@\.virtualenvs\/'"$HOSTENVNAME"'@\.virtualenvs\/env@g' /root/.virtualenvs/env/bin/pip

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
sed -i -e 's@bash@'"$SHELLNAME"'@g' /root/.virtualenvs/env/bin/preactivate
sed -i -e 's@VIRTUAL_ENV="\/root@VIRTUAL_ENV="'"$HOSTHOMEPATH"'@g' /root/.virtualenvs/env/bin/activate
sed -i -e 's@\/root@'"$HOSTHOMEPATH"'@g' /root/.virtualenvs/env/bin/pip
sed -i -e 's@\.virtualenvs\/env@\.virtualenvs\/'"$HOSTENVNAME"'@g' /root/.virtualenvs/env/bin/activate
sed -i -e 's@\.virtualenvs\/env@\.virtualenvs\/'"$HOSTENVNAME"'@g' /root/.virtualenvs/env/bin/pip
echo "clean up, quit"
