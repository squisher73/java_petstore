FROM jboss/wildfly:8.2.0.Final
COPY postgresql-9.3-1103.jdbc3.jar /
COPY execute.sh /
COPY datasource.cli /
COPY ROOT.war /opt/jboss/wildfly/standalone/deployments/
USER jboss
RUN /execute.sh
