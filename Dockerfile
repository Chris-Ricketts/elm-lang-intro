FROM debian:latest
 
# prepare
RUN apt-get -y update
RUN apt-get -y install apt-utils
 
# install curl & gnupg2
RUN apt-get -y install curl gnupg2
 
# node + npm
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get install -y nodejs
 
# elm
RUN npm install -g elm
RUN npm install -g elm-test
 
# nginx
RUN apt-get install -y nginx
 
# make elm reactor and nginx accessible
EXPOSE 8000 80
