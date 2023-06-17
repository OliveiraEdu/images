FROM rust:1.67 as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .

FROM bitnami/minideb:bullseye

RUN set -ex

RUN apt-get clean && apt-get update -yq; \
    apt-get install -y --no-install-recommends python3-pip patchelf extra-runtime-dependencies sudo gnupg wget x11vnc dbus-x11 unzip xvfb fluxbox net-tools nano curl lxterminal firefox-esr thunar geany midori git python3-venv pkg-config; \
    pip3 install --upgrade pip; \
    pip3 install maturin; \


RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*
    
COPY --from=builder /usr/local/cargo/bin/myapp /usr/local/bin/myapp
#CMD ["myapp"]

WORKDIR /build
COPY . .
RUN maturin build
RUN pip3 install target/wheels/*

WORKDIR /test

RUN mkdir -p ~/Git
RUN cd ~/Git
RUN git clone https://github.com/hyperledger/iroha.git --branch iroha2-stable
RUN git clone https://github.com/OliveiraEdu/iroha2_python


COPY startup /usr/local/bin/
COPY hosts /etc

CMD ["bash","startup"]

EXPOSE 5900
