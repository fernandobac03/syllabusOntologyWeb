FROM debian:latest
MAINTAINER Fernando Baculima


# Install required packages

ENV TOMCATVER 7.0.73




RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

RUN apt-get -q -y update && apt-get -q -y upgrade && apt-get -q -y install \ 
				libcups2 \
				nano \
				wget \
				python-dev \
				libpq-dev \
				&& apt-get -q clean

RUN (apt-get update && DEBIAN_FRONTEND=noninteractive apt install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java)

RUN (wget -O /tmp/tomcat7.tar.gz http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCATVER}/bin/apache-tomcat-${TOMCATVER}.tar.gz && \
  cd /opt && \
  tar zxf /tmp/tomcat7.tar.gz && \
  mv /opt/apache-tomcat* /opt/tomcat && \
  rm /tmp/tomcat7.tar.gz)

### to deploy a specific war to ROOT, uncomment the following 2 lines and specify the appropriate .war
RUN rm -rf /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples /opt/tomcat/webapps/ROOT
COPY /ontologia/ /opt/tomcat/webapps/ontologia/

#Changing default tomcat port
RUN sed 's/8080/8081/g' /opt/tomcat/conf/server.xml > newserver.xml
RUN mv newserver.xml /opt/tomcat/conf/server.xml

EXPOSE 8081

COPY /start_tomcat.sh /
RUN chmod +x /start_tomcat.sh
CMD ["/start_tomcat.sh"]

