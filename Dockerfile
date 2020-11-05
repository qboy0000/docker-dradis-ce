FROM ubuntu:18.04
MAINTAINER "qgw <guow.qiu@gmail.com>"

ENV RUBY_VERSION=2.4
ENV RUBY_PACKAGE=ruby-2.4.1

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt update && \
    apt upgrade -y && \

# set time zone
	apt-get install -y tzdata && \
	echo "Asia/Shanghai" > /etc/timezone && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata && \

    apt install -y git wget gcc g++ make libsqlite3-dev sqlite3 zlib1g-dev zlibc openssl libssl-dev && \
    wget https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION}/${RUBY_PACKAGE}.tar.bz2 -O /tmp/${RUBY_PACKAGE}.tar.bz2 && \
    cd /tmp && \
    tar -xvf ${RUBY_PACKAGE}.tar.bz2 && \
    cd ${RUBY_PACKAGE} && \
    ./configure --with-openssl-dir=/usr/lib/ssl && make && make install && \

    mkdir -p /dradis && \
    cd /dradis && \
    git clone https://github.com/dradis/dradis-ce.git && \

    groupadd dradis && \
 	useradd -r -u 1000 -d /dradis -m -g dradis dradis && \
 	chown -R dradis:dradis /dradis && \
 	ruby dradis-ce/bin/setup && \
 	apt purge -y wget gcc g++ make && \
 	apt autoremove -y && \
 	rm -rf /tmp/*

WORKDIR /dradis/dradis-ce
EXPOSE 3000

#USER dradis

CMD bundle exec rails server -b 0.0.0.0
