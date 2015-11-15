FROM jboss/wildfly
ADD ROOT.war /opt/jboss/wildfly/standalone/deployments/


# download jolokia in the sti builder
#RUN mkdir /opt/jolokia && curl -L http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar > /opt/jolokia/jolokia.jar

#FROM jboss/wildfly:8.2.0.Final

#USER jboss
# allow jboss user access to /opt/jboss and /opt/karaf
#squisher73	3F6IrrK5Hd7nOtcxhd1qFx4cK
RUN chown -R 1000 /opt/jboss

# STI requires a numeric, non-0 UID
#USER 1000
 
#CMD ["/usr/bin/usage"]
