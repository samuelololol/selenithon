# selenithon

A selenium enabled python interpreter based on docker container


# try it

```
$ mkvirtualenv dse
$ docker run -it --rm  -v "/home/samuel/.virtualenvs/dse:/root/.virtualenvs/env" -v "$(pwd):/app" dse python test.py
```

# trouble shooting

```
...
...
selenium.common.exceptions.NoSuchWindowException: Message: Browsing context has been discarded

```

>> Add option: memory limit 2G `docker --shm-size=2g ...`
