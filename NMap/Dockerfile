FROM ubuntu:18.04

LABEL "com.github.actions.name"="NMap"
LABEL "com.github.actions.description"="NMaps Host And Uploads Findings To Issue"
LABEL "com.github.actions.icon"="cloud-lightning"
LABEL "com.github.actions.color"="Red"
LABEL "maintainer"="gitgrub <gitgrub.email@gmail.com>"

RUN echo ----------------------------------------------------- && \
  ls -la / && \
  echo -----------------------------------------------------

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

ARG TTEST
ENV env_ttest=$TTEST
ARG GH_TOKEN
ENV env_gh_token=$GH_TOKEN

# ADD hier
# ENV für die shell

ADD ./NMap/entrypoint.sh /entrypoint.sh
ADD ./scan.txt /scan.txt
ADD ./ports.txt /ports.txt
RUN /entrypoint.sh
