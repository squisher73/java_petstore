FROM jboss/wildfly:8.2.0.Final
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/
COPY postgresql-9.3-1103.jdbc3.jar /opt/jboss/wildfly/standalone/deployments/
COPY postgres-ds.xml /opt/jboss/wildfly/standalone/deployments/
COPY target/ROOT.war /opt/jboss/wildfly/standalone/deployments/
