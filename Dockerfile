FROM selenium/standalone-firefox
MAINTAINER samuelololol <samuelololol@gmail.com>
USER root
RUN mkdir -p /app
WORKDIR /app
RUN apt-get update
RUN apt-get install -y python-dev python-pip xvfb\
            libgtk-3-0 libgtk-3-common libdbus-glib-1-dev
RUN pip install --upgrade pip
RUN pip install xvfbwrapper pyvirtualdisplay\
                selenium selenium-requests requests\
		virtualenv virtualenvwrapper
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt-lists/*
ADD entry_point.sh /entry_point.sh
ENTRYPOINT ["/entry_point.sh"]
WORKDIR /app
CMD ["python"]
