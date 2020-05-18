FROM lsiobase/alpine.python3:3.9
RUN apk add alpine-sdk zlib-dev git libffi-dev musl-dev openssl-dev jpeg-dev && apk add nodejs --update-cache -X http://dl-3.alpinelinux.org/alpine/edge/main/ --allow-untrusted && rm -rf /node-10.4.2* /SHASUM256.txt /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

WORKDIR /doge
# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

COPY pip.txt pip.txt
RUN  pip3 install -r pip.txt 

RUN git clone https://github.com/jasii/doge ./doge && \
    mkdir -p data && \
    cp doge.config.default.json doge.config.json && \
    chown abc:abc doge.config.json
RUN git clone https://github.com/jasii/nut ./nut && \
    touch nut/keys.txt && \
    mkdir -p init/nut/conf/ && \
    cp nut/conf/* ./init/nut/conf/ && \
    chown -R abc:abc .
COPY --chown=abc:abc start_doge.sh .
RUN chmod +x ./start_doge.sh

ENTRYPOINT ["./start_doge.sh"]
