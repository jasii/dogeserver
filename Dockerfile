FROM lsiobase/alpine
WORKDIR /doge
# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN apk add nodejs --update-cache -X http://dl-3.alpinelinux.org/alpine/edge/main/ --allow-untrusted
RUN pip3 install --upgrade pip && \
    pip3 install colorama pyopenssl requests tqdm unidecode Pillow BeautifulSoup4 urllib3 Flask google-api-python-client google-auth-oauthlib
RUN git clone https://github.com/jasii/doge . && \
    mkdir -p data && \
    cp doge.config.default.json doge.config.json && \
    chown abc:abc doge.config.json
RUN git clone https://github.com/blawar/nut ./nut && \
    touch nut/keys.txt && \
    mkdir -p init/nut/conf/ && \
    cp nut/conf/* ./init/nut/conf/ && \
    chown -R abc:abc .
COPY --chown=abc:abc start_doge.sh .
RUN chmod +x ./start_doge.sh

ENTRYPOINT ["./start_doge.sh"]
