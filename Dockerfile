# download jolokia in the sti builder
RUN mkdir /opt/jolokia && curl -L http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar > /opt/jolokia/jolokia.jar
 
#USER jboss
# allow jboss user access to /opt/jboss and /opt/karaf
RUN chown -R 1000 /opt/jboss

# STI requires a numeric, non-0 UID
USER 1000
 
CMD ["/usr/bin/usage"]
