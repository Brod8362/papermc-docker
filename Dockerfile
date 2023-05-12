FROM alpine:3.17
ARG PAPERMC_VERSION=latest
ARG PAPERMC_BUILD=latest
# install JDK
RUN apk update
RUN apk add openjdk17-jre-headless curl jq

# download server jar
COPY download_paper_version.sh /tmp
RUN mkdir /jar
RUN /tmp/download_paper_version.sh /jar/server.jar $PAPERMC_VERSION $PAPERMC_BUILD
RUN rm /tmp/download_paper_version.sh

EXPOSE 25565

# server folder should be mounted to /srv
WORKDIR /srv

ENTRYPOINT ["java", "-Xmx6G", "-jar", "/jar/server.jar"]
