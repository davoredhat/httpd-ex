FROM registry.redhat.io/ubi9/httpd-24

# Add application sources to a directory where the assemble script expects them
# and set permissions so that the container runs without the root access
USER 0
ADD index.html /tmp/src/index.html

#Agrega certificados
ADD httpd-ssl/certs/server.pem /tmp/src/httpd-ssl/certs/server.pem
ADD httpd-ssl/private/server-key.pem /tmp/src/httpd-ssl/private/server-key.pem

RUN chown -R 1001:0 /tmp/src

USER 1001

# Let the assemble script install the dependencies
RUN /usr/libexec/s2i/assemble

# The run script uses standard ways to run the application
CMD /usr/libexec/s2i/run