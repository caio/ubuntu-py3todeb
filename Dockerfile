FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y -q \
    python3-pip git python3-dev libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev python-setuptools \
    build-essential curl devscripts equivs git-buildpackage git lsb-release make openssh-client pristine-tar rake rsync ruby ruby-dev rubygems wget

RUN echo "gem: --no-ri --no-rdoc" >/etc/gemrc
RUN gem install fpm

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

WORKDIR /app
COPY . /app
CMD python3 ./build.py
