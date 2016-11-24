FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN ["apt-get", "update"]
RUN ["apt-get", "-yq", "install", "openjdk-8-jre"]

ENV CATALINA_BASE /var/lib/tomcat7
ENV LOGS_DIR /var/lib/tomcat7/logs
RUN mkdir -p $CATALINA_BASE/temp
RUN ["apt-get", "-yq", "install", "tomcat7"]

COPY ./mountebank_1.6.0_amd64.deb /tmp/mountebank_1.6.0_amd64.deb
RUN ["dpkg", "-i", "/tmp/mountebank_1.6.0_amd64.deb"]

COPY ./log4j-1.2.17.jar $CATALINA_BASE/lib/log4j.jar
COPY ./tomcat-juli-adapters-7.0.8.jar $CATALINA_BASE/lib/tomcat-juli-adapters.jar
COPY ./tomcat-juli-7.0.8.jar /usr/share/tomcat7/bin/tomcat-juli.jar
COPY ./apache-log4j-extras-1.2.17.jar $CATALINA_BASE/lib/apache-log4j-extras.jar

CMD /usr/share/tomcat7/bin/startup.sh && mb
