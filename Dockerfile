FROM lsiobase/alpine.python3:3.8
WORKDIR /doge
RUN apk add nodejs --update-cache -X http://dl-3.alpinelinux.org/alpine/edge/main/ --allow-untrusted
RUN pip3 install --upgrade pip && \
    pip3 install colorama pyopenssl requests tqdm unidecode image bs4 urllib3 flask
RUN git clone https://github.com/jasii/doge . && \
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
