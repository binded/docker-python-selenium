FROM python:3.6.1
MAINTAINER Binded (info@binded.com)

ENV CHROME_DRIVER_VERSION=2.30

RUN apt-get update && apt-get install -y apt-utils && rm -rf /var/lib/apt/lists/*

# TODO: do we really need all this? e.g. openjdk...
RUN apt-get update && apt-get install -y \
  libxss1 \
  libappindicator1 \
  libindicator7 \
  openjdk-7-jre-headless \
  xvfb \
  libxi6 \
  libgconf-2-4 \
  libasound2 \
  libgtk-3-0 \
  fonts-liberation \
  xdg-utils \
  unzip \
  lsb-release \
  && rm -rf /var/lib/apt/lists/*

# Install Chrome.
RUN wget -N "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -P /tmp/
RUN dpkg -i --force-depends /tmp/google-chrome-stable_current_amd64.deb
RUN apt-get -f install -y

# Install ChromeDriver.
RUN wget -N "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip" -P /tmp/ \
  && unzip /tmp/chromedriver_linux64.zip \
  && chmod u+x ./chromedriver \
  && mv ./chromedriver /usr/local/bin/chromedriver \
  && rm /tmp/chromedriver_linux64.zip
