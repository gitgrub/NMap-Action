FROM ubuntu:18.04

LABEL "com.github.actions.name"="NMap"
LABEL "com.github.actions.description"="NMaps Host And Uploads Findings To Issue"
LABEL "com.github.actions.icon"="cloud-lightning"
LABEL "com.github.actions.color"="Red"
LABEL "maintainer"="gitgrub <gitgrub.email@gmail.com>"

RUN echo ----------------------------------------------------- && \
  ls -la / && \
  echo -----------------------------------------------------
#RUN wertgezhhuj

RUN apt-get update && apt-get install -y \
  curl \
  git \
  wget \
  nmap && \
  cd /usr/share/nmap/scripts/ && \
  git clone https://github.com/vulnersCom/nmap-vulners.git && \
  git clone https://github.com/scipag/vulscan.git && \
  ls vulscan/*.csv && \
  cd vulscan/utilities/updater/ && \
  chmod +x updateFiles.sh && \
  ./updateFiles.sh

#ADD entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

#RUN nmap -v -p 1-3000 www.abv-styling.at
#-p- -A -p 1-3000
#RUN find / -name entrypoint.sh

ARG TTEST
ENV env_ttest=$TTEST
ARG GH_TOKEN
ENV env_gh_token=$GH_TOKEN

RUN echo --------------------------------
RUN echo 1 $TTEST
RUN echo 2 $GH_TOKEN
RUN echo 3 env_ttest
RUN echo 4 $env_ttest
RUN echo --------------------------------

ADD ./NMap/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ADD ./scan.txt /scan.txt
RUN /entrypoint.sh $TTEST
