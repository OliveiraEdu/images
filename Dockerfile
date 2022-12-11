# Dockerfile

FROM bitnami/minideb:bullseye

RUN apt-get clean && apt-get update && apt-get install -y gnupg wget x11vnc dbus-x11 unzip xvfb fluxbox net-tools nano curl lxterminal firefox-esr python3 python3-pip thunar geany midori git python3-venv

RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/repo

WORKDIR /home/repo            

RUN git clone https://github.com/OliveiraEdu/iroha_python_flask

WORKDIR /home/repo/iroha_python_flask

RUN pip3 install virtualenv

RUN python3 -m venv env

RUN source env/bin/activate

RUN pip3 install -r requirements.txt

COPY startup /usr/local/bin/

CMD ["bash","startup"]

EXPOSE 5900
