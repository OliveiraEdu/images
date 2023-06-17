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


# ---------
ENV VIRTUAL_ENV=/home/repo/iroha_python_flask/env
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
RUN pip install -r requirements.txt

# Run the application:
CMD ["python", "main_sample.py"]
# --------

COPY startup /usr/local/bin/

CMD ["bash","startup"]

EXPOSE 5900
