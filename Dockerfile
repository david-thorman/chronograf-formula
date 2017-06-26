FROM ubuntu:14.04
MAINTAINER David Thorman <dcthorman25@gmail.com>

RUN apt-get -qq update && apt-get install -y curl vim
RUN curl -s -o- https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" | tee /etc/apt/sources.list.d/saltstack.list
RUN apt-get -qq update && apt-get install -y salt-minion

RUN mkdir -p /srv/salt/base/states && mkdir -p /srv/salt/base/pillars
RUN echo "file_roots:\n  base:\n    - /srv/salt/base/states\npillar_roots:\n  base:\n    - /srv/salt/base/pillars" | tee /etc/salt/minion.d/roots.conf
RUN echo "base:\n  '*':\n    - kapacitor" | tee /srv/salt/base/states/top.sls
RUN echo "base:\n  '*':\n    - kapacitor" | tee /srv/salt/base/pillars/top.sls

COPY chronograf /srv/salt/base/states/chronograf
COPY pillar.example /srv/salt/base/pillars/chronograf/init.sls
