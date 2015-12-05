FROM jboss/wildfly:8.2.0.Final
COPY postgresql-9.3-1103.jdbc3.jar /
COPY datasource.cli /
COPY target/ROOT.war /opt/jboss/wildfly/standalone/deployments/
RUN /opt/jboss/wildfly/bin/standalone.sh -c standalone.xml
RUN sleep 30s
RUN /opt/jboss/wildfly/jboss-cli.sh --file=/datasource.cli
RUN /opt/jboss/wildfly/jboss-cli.sh -c ":shutdown"
