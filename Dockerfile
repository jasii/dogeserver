FROM lsiobase/alpine.python3:3.8
WORKDIR /doge
RUN apk add nodejs --update-cache -X http://dl-3.alpinelinux.org/alpine/edge/main/ --allow-untrusted
RUN pip3 install --upgrade pip
RUN pip3 install colorama pyopenssl requests tqdm unidecode image bs4 urllib3 flask
RUN git clone https://github.com/wowsuchdoge/doge .
RUN git clone https://github.com/blawar/nut ./nut

COPY --chown=abc:abc start.sh /start.sh
COPY --chown=abc:abc ./doge.config.default.json ./doge.config.json
COPY --chown=abc:abc ./nut/conf /init/nut/conf

RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]
