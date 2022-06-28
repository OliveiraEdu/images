# Dockerfile
# Geth and tools

FROM bitnami/minideb:bullseye

RUN apt-get clean && apt-get update && apt-get install -y gnupg wget x11vnc dbus-x11 unzip xvfb fluxbox net-tools nano curl lxterminal firefox-esr python3 python3-pip thunar geany midori git python3-venv

RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

#RUN pip3 install jupyterlab
#RUN pip install --user numpy scipy matplotlib pandas sympy nose seaborn

RUN mkdir -p /home/repo

WORKDIR /home/repo            

RUN git clone https://github.com/OliveiraEdu/iroha_python_flask

WORKDIR /home/repo/iroha_python_flask

RUN pip3 install virtualenv

RUN python3 -m venv env

#COPY env /usr/local/bin/

#CMD ["bash","env"]

COPY startup /usr/local/bin/

CMD ["bash","startup"]

RUN env/bin/pip3 install -r requirements.txt

#RUN lxterminal

EXPOSE 5900
