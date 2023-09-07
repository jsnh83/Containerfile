FROM registry.access.redhat.com/ubi8/ubi:8.0

LABEL version="1.0" description="this is Containerfile" \ 
      maintainer="Red Hat Training <training@redhat.com>"

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

RUN yum install -y  --disableplugin=subscription-manager httpd && \
    yum clean all --disableplugin=subscription-manager -y && \
    echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html && \
     rm -rf /run/httpd && mkdir /run/httpd

ADD file1.txt file2.txt /var

ONBUILD COPY src/ $DOCROOT/
EXPOSE 80




# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
