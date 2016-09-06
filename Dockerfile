FROM ubuntu
MAINTAINER Nikolay Glushchenko <nick@nickalie.com>
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y wget apt-transport-https nsis default-jre git-core wine build-essential python --no-install-recommends && \
    wget -O - https://deb.nodesource.com/setup_6.x | bash && \
    apt-get install -y nodejs --no-install-recommends && \
    apt-get clean

ENV WINEARCH win32
ENV WINEPREFIX /wine32
RUN wineboot && \
    wineboot -s && \
    rm -rf /tmp/.wine-0
