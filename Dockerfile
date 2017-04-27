FROM ubuntu
MAINTAINER Nikolay Glushchenko <nick@nickalie.com>
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y ssh software-properties-common wget apt-transport-https nsis default-jre git-core build-essential python unzip curl --no-install-recommends && \
    wget https://dl.winehq.org/wine-builds/Release.key && \
    apt-key add Release.key && \
    apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ && \
    rm Release.key && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    wget -O - https://deb.nodesource.com/setup_7.x | bash && \
    apt-get install -y nodejs winehq-stable google-cloud-sdk yarn --no-install-recommends && \
    apt-get clean

ENV WINEPREFIX /wine32
RUN wineboot && \
    wineboot -s && \
    rm -rf /tmp/.wine-0

RUN wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    rm -rf ./awscli-bundle && \
    rm awscli-bundle.zip
