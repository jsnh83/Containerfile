FROM registry.access.redhat.com/ubi8/ubi:8.0

LABEL version="1.0"  description="this is Containerfile"  \
      maintainer="Red Hat Training <training@redhat.com>"

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

RUN yum install -y  --disableplugin=subscription-manager httpd && \
    yum clean all --disableplugin=subscription-manager -y  && \
    echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html && rm -rf /run/httpd && mkdir /run/httpd

ONBUILD COPY src/ $DOCROOT/

EXPOSE 8080

# This stuff is needed to ensure a clean start


# Run as the root user
USER root

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
