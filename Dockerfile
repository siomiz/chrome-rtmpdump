FROM siomiz/chrome

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ADD https://github.com/K-S-V/Scripts/releases/download/v2.4/rtmpdump-2.4.zip /tmp/

COPY rtmpsrv.diff /tmp/

RUN apt-get update \
	&& apt-get install -y \
	build-essential \
	git-core \
	iptables \
	libssl-dev \
	unzip

WORKDIR /tmp

RUN unzip rtmpdump-2.4.zip

WORKDIR /usr/local/src

RUN git clone git://git.ffmpeg.org/rtmpdump

WORKDIR /usr/local/src/rtmpdump

RUN patch -p0 < /tmp/Patch.diff
RUN patch -p1 < /tmp/rtmpsrv.diff

RUN make && make install

COPY ep-rtmpdump.sh /
RUN chmod +x /ep-rtmpdump.sh

ENTRYPOINT ["/ep-rtmpdump.sh"]

CMD ["/crdonly"]
