FROM registry.access.redhat.com/ubi8/ubi:8.0
LABEL version="1.0" description="this is Containerfile"
LABEL maintainer="Red Hat Training <training@redhat.com>"

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

ADD rhtgs.sh /scripts

RUN yum install -y  --disableplugin=subscription-manager httpd
RUN yum clean all --disableplugin=subscription-manager -y 
RUN echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html 
RUN rm -rf /run/httpd
RUN mkdir /run/httpd
ADD scripts.sh /scripts/

# Expose the port
EXPOSE 80

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
