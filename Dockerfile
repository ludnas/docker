FROM alpine

RUN apk add -q build-base libevent libevent-dev openssl-dev zlib-dev
RUN    mkdir /temp \
    && wget https://dist.torproject.org/tor-0.4.4.5.tar.gz -P /temp
WORKDIR /temp

RUN    tar xzf tor-0.4.4.5.tar.gz \
    && cd tor-0.4.4.5 \
    && export PATH=/usr/lib:$PATH \
    && ./configure && make && make install \
    && rm /temp -fR


FROM alpine

COPY --from=0 /usr/lib /usr/lib
COPY --from=0 /usr/local/bin /usr/local/bin

EXPOSE 9050

ENTRYPOINT tor


