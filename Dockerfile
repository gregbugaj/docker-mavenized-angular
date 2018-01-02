FROM node:9.1

MAINTAINER Greg Bugaj "gregbugaj@yahoo.com"

ENV DEBIAN_FRONTEND noninteractive
# First make sure the base system is up-to-date
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq upgrade
RUN apt-get install -y apt-utils
RUN apt-get update


RUN \
   echo ">> Installing Java <<"  \
   && export DEBIAN_FRONTEND=noninteractive \
   && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list  \
   && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
   && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
   && apt-get update \
   && apt-get upgrade -y \
   && apt-get install -y software-properties-common \
   && apt-get update \
   && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
   && apt-get  install -y oracle-java8-installer \
   && echo ">> Cleanup <<"  \
   && rm -rf /var/cache/oracle-jdk8-installer \
   && apt-get clean  \
   && rm -rf /var/lib/apt/lists/* \
   && java -version
   && echo "Insalling Angular CLI"
   && npm install -g @angular/cli
