FROM ubuntu:14.04

# build: docker build -t foo .
# run  : docker run -d -p 80:80 --name foo foo

RUN apt-get update; apt-get install -y nginx python

EXPOSE 80 8080

ADD nginx.conf /nginx.conf
ADD nginx_proxies /nginx_proxies
ADD docs /docs

ADD run.sh /run.sh
CMD /run.sh