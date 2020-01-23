FROM mcr.microsoft.com/mssql-tools

LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/lenisha/aks-tests"

LABEL maintainer="Elena Neros<lenisha@gmail.com>"

COPY Dockerfile /Dockerfile

RUN apt-get update \
    && apt-get install -y traceroute wget dnsutils netcat-openbsd jq nmap \ 
                          net-tools git openssh-client   \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

CMD /bin/bash 
