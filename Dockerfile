FROM jboss/wildfly:8.2.0.Final
ADD ROOT.war /opt/jboss/wildfly/standalone/deployments/
