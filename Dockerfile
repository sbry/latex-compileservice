FROM registry.gitlab.com/islandoftex/images/texlive:latest

COPY requirements.txt ./requirements.txt

RUN apt-get update && \
    apt -y update && apt -y upgrade && \
    apt install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m venv /workdir && \
    . /workdir/bin/activate && \
    pip install -r requirements.txt && \
    mkdir /working && \
    mkdir -p /var/www/app

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV CELERY_LOG_LEVEL=info
ENV COMPONENT=web
ENV FLASK_ENV=production

COPY ./ /var/www/app

CMD /var/www/app/run.sh