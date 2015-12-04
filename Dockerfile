FROM jboss/wildfly:8.2.0.Final
	#COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/
	#RUN curl -L -o /tmp/psql-jdbc.jar http://jdbc.postgresql.org/download/postgresql-9.3-1103.jdbc3.jar
COPY postgresql-9.3-1103.jdbc3.jar /
COPY execute.sh /
COPY datasource.cli /
	#COPY postgres-ds.xml /opt/jboss/wildfly/standalone/deployments/
	#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
COPY ROOT.war /opt/jboss/wildfly/standalone/deployments/
	#RUN /opt/jboss/wildfly/config.sh
RUN /execute.sh
