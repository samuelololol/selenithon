# selenithon

A selenium enabled python interpreter based on docker container


# try it

```
$ mkvirtualenv dse
$ docker run -it --rm  -v "/home/samuel/.virtualenvs/dse:/root/.virtualenvs/env" -v "$(pwd):/app" dse python test.py
```
