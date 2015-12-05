FROM jboss/wildfly:8.2.0.Final
COPY postgresql-9.3-1103.jdbc3.jar /
COPY datasource.cli /
COPY ROOT.war /opt/jboss/wildfly/standalone/deployments/
RUN /opt/jboss/wildfly/bin/standalone.sh -c standalone.xml &\
 sleep 120s  &&\
 /opt/jboss/wildfly/bin/jboss-cli.sh --file=/datasource.cli  &&\
 /opt/jboss/wildfly/bin/jboss-cli.sh -c ":shutdown"
