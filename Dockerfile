FROM jboss/wildfly:8.2.0.Final
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
ADD ROOT.war /opt/jboss/wildfly/standalone/deployments/
