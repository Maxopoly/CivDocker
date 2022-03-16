FROM debian:11.2

RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y openjdk-17-jdk wget htop iotop byobu gettext-base

ARG PAPER_MAJOR_VERSION=1.18.2
ARG PAPER_MINOR_VERSION=254

RUN mkdir /paper
WORKDIR /paper
RUN wget -O paper.jar https://papermc.io/api/v2/projects/paper/versions/${PAPER_MAJOR_VERSION}/builds/${PAPER_MINOR_VERSION}/downloads/paper-${PAPER_MAJOR_VERSION}-${PAPER_MINOR_VERSION}.jar

RUN mkdir plugins

ADD start.sh /paper/start.sh

CMD ["bash", "/paper/start.sh"]

EXPOSE 25565/tcp