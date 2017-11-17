#FROM selenium/standalone-firefox
FROM samuelololol/docker-selenium
MAINTAINER samuelololol <samuelololol@gmail.com>
ENV VER=0.19.1
#VER=$(wget -O - https://github.com/mozilla/geckodriver/releases/latest 2>/dev/null | grep "Release v"  | awk -F "Release v" '{print $2}' | awk -F " " '{print $1}'); \
USER root
RUN mkdir -p /app
WORKDIR /app
RUN apt-get update
RUN apt-get install -y python-dev python-pip xvfb\
            libgtk-3-0 libgtk-3-common libdbus-glib-1-dev
RUN pip install --upgrade pip
RUN pip install xvfbwrapper pyvirtualdisplay\
                selenium selenium-requests requests\
                virtualenv virtualenvwrapper \
                lxml BeautifulSoup
RUN cd /app; \
    LINK_PREFIX="https://github.com/mozilla/geckodriver/releases/download"; \
    wget $LINK_PREFIX"/v"$VER"/geckodriver-v"$VER"-linux64.tar.gz"
RUN cd /app; \
    tar zxf geckodriver*; \
    chmod +x geckodriver; chown root.root geckodriver; mv geckodriver /usr/local/bin; \
    rm -rf /app/*
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt-lists/*
WORKDIR /app
ADD entry_point.sh /entry_point.sh
ENTRYPOINT ["/entry_point.sh"]
CMD ["python"]
