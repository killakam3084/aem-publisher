# DOCKER-VERSION 1.0.1
FROM iillmaticc/aem-base
MAINTAINER vzfg38

# Extracts AEM
WORKDIR /aem
COPY cq-6.2.jar /aem/cq-6.2.jar
RUN java -Xmx2048M -jar cq-6.2.jar -unpack -r publish -p 4503
COPY license.properties /aem/license.properties


# Installs AEM
RUN python aemInstaller.py -i cq-6.2.jar -r publish -p 4503

WORKDIR /aem/crx-quickstart/bin

#Replaces the port within the quickstart file with the standard publish port

ONBUILD RUN cp quickstart quickstart.original
ONBUILD RUN cat quickstart.original | sed "s|4502|4503|g" > quickstart


EXPOSE 4503 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
